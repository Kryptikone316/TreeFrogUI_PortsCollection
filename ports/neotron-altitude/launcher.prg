program launcher;
// SPDX-License-Identifier: Unlicense

// Altitude launcher for the Datafrog SF3500 port (a mod: it sits in front of the unmodified game).
//
// Screens: Play Game, Options, How to Play, Exit.
// It reads the game's own graphics (altitude.fpg) and menu music (alt1.mod) but never changes
// any of the game's files. Its only outputs are options.cfg (settings) and
// launcher_action.txt (what run.sh should do next: "play", or nothing to leave).
//
// The layout is designed on a 640x480 grid, but the screen is 480x360: the display driver drops
// frames wider than 640x480, and a 480x360 frame padded to 16:9 is exactly 640x360. The leaf
// drawing functions below scale design coordinates by 3/4. Text uses the fonts in ui/*.fnt
// (made by make-fonts.py at 3/4 of the design size), which are drawn on the solid panel colour
// c_panel below; keep the two the same.
//
// Run with the argument "shots" (and SF3500_SHOT_PREFIX set) to dump each screen and quit.

import "mod_video";
import "mod_key";
import "mod_text";
import "mod_sound";
import "mod_map";
import "mod_grproc";
import "mod_proc";
import "mod_file";
import "mod_screen";
import "mod_draw";
import "mod_string";
import "mod_sys";
import "mod_math";
import "mod_time";

const
    SCR_MAIN    = 0;
    SCR_OPTIONS = 1;
    SCR_HELP    = 2;
    HELP_PAGES  = 5;
    ALL         = 0;
end

global
    int fpg;
    int song;
    int snd_select;
    int f_head; int f_menu_w; int f_menu_y; int f_w; int f_y; int f_g; int f_r;
    int opt_fill  = 0;          // 0 = original 4:3 shape, 1 = fill the screen
    int opt_music = 1;
    int opt_bot   = 0;          // computer opponent: 0 off, 1 easy, 2 normal, 3 hard
    int creator_best = 0;       // Imerion's (the author's) high score, shipped in score-creator.dat
    int player_best = 0;        // the player's own best, kept by the runtime in score-player.dat
    int reset_stage = 0;        // Options: 0 idle, 1 waiting for the confirming press, 2 done
    int cur_screen = 0;
    int sel = 0;
    int help_page = 0;
    int dirty = 1;
    int shots = 0;
    int prev_up; int prev_down; int prev_left; int prev_right; int prev_enter; int prev_esc;
    int e_up; int e_down; int e_left; int e_right; int e_enter; int e_esc;
    int c_panel; int c_edge; int c_yellow;
    string menu_item[3];
end

begin
    set_mode(480, 360, 16);
    set_fps(20, 0);

    c_panel  = rgb(16, 16, 26);
    c_edge   = rgb(95, 95, 115);
    c_yellow = rgb(255, 215, 60);

    menu_item[0] = "Play Game";
    menu_item[1] = "Options";
    menu_item[2] = "How to Play";
    menu_item[3] = "Exit";

    load_cfg();
    if (file_exists("score-creator.dat")) load("score-creator.dat", creator_best); else load("score.dat", creator_best); end
    if (file_exists("score-player.dat")) load("score-player.dat", player_best); end

    fpg = load_fpg("altitude.fpg");
    f_head   = fnt_load("ui/head.fnt");
    f_menu_w = fnt_load("ui/menu_w.fnt");
    f_menu_y = fnt_load("ui/menu_y.fnt");
    f_w      = fnt_load("ui/body_w.fnt");
    f_y      = fnt_load("ui/body_y.fnt");
    f_g      = fnt_load("ui/body_g.fnt");
    f_r      = fnt_load("ui/body_r.fnt");
    song = load_song("alt1.mod");
    snd_select = load_wav("select.wav");

    if (argc > 1)
        if (argv[1] == "shots") shots = 1; end
        if (argv[1] == "selftest") run_selftest(); end
    end

    if (shots == 1)
        run_shots();
        exit("", 0);
    end

    if (opt_music == 1 and song => 0) play_song(song, -1); end

    loop
        e_up    = key(_up)    and not prev_up;    prev_up    = key(_up);
        e_down  = key(_down)  and not prev_down;  prev_down  = key(_down);
        e_left  = key(_left)  and not prev_left;  prev_left  = key(_left);
        e_right = key(_right) and not prev_right; prev_right = key(_right);
        e_enter = key(_enter) and not prev_enter; prev_enter = key(_enter);
        e_esc   = key(_esc)   and not prev_esc;   prev_esc   = key(_esc);

        if (cur_screen == SCR_MAIN)    handle_main();    end
        if (cur_screen == SCR_OPTIONS) handle_options(); end
        if (cur_screen == SCR_HELP)    handle_help();    end

        if (dirty == 1)
            dirty = 0;
            draw_screen();
        end
        frame;
    end
end

// ---------------------------------------------------------------- input handling

function handle_main()
begin
    if (e_up)   sel = (sel + 3) % 4; dirty = 1; end
    if (e_down) sel = (sel + 1) % 4; dirty = 1; end
    if (e_enter)
        click();
        if (sel == 0) finish("play"); end
        if (sel == 1) cur_screen = SCR_OPTIONS; sel = 0; dirty = 1; end
        if (sel == 2) cur_screen = SCR_HELP; help_page = 0; dirty = 1; end
        if (sel == 3) finish("exit"); end
    end
end

function handle_options()
begin
    if (e_up)   sel = (sel + 4) % 5; reset_stage = 0; dirty = 1; end
    if (e_down) sel = (sel + 1) % 5; reset_stage = 0; dirty = 1; end
    if (e_left or e_right or e_enter)
        if (sel == 0)
            opt_fill = 1 - opt_fill;
            save_cfg();
            click();
            dirty = 1;
        end
        if (sel == 1)
            opt_music = 1 - opt_music;
            if (opt_music == 1) play_song(song, -1); else stop_song(); end
            save_cfg();
            click();
            dirty = 1;
        end
        if (sel == 2)
            if (e_left) opt_bot = (opt_bot + 3) % 4; else opt_bot = (opt_bot + 1) % 4; end
            save_cfg();
            click();
            dirty = 1;
        end
        if (sel == 3 and e_enter)
            // two presses: the first arms it, the second does it
            if (reset_stage == 1)
                reset_scores();
                reset_stage = 2;
            else
                reset_stage = 1;
            end
            click();
            dirty = 1;
        end
        if (sel == 4 and e_enter)
            click();
            cur_screen = SCR_MAIN; sel = 1; dirty = 1;
        end
    end
    if (e_esc)
        reset_stage = 0;
        cur_screen = SCR_MAIN; sel = 1; dirty = 1;
    end
end

// Imerion's score goes back into the game's own high-score file and the player's best is set to 0.
function reset_scores()
begin
    save("score.dat", creator_best);
    player_best = 0;
    save("score-player.dat", player_best);
end

function handle_help()
begin
    if (e_right or e_enter)
        help_page = help_page + 1;
        if (help_page == HELP_PAGES)
            cur_screen = SCR_MAIN; sel = 2;
        end
        dirty = 1;
    end
    if (e_left and help_page > 0)
        help_page = help_page - 1;
        dirty = 1;
    end
    if (e_esc)
        cur_screen = SCR_MAIN; sel = 2; dirty = 1;
    end
end

function click()
begin
    if (opt_music == 1 and snd_select => 0) play_wav(snd_select, 0); end
end

// ---------------------------------------------------------------- settings and hand-off

function load_cfg()
private
    int f;
    string l;
begin
    if (file_exists("options.cfg"))
        f = fopen("options.cfg", O_READ);
        if (f)
            while (not feof(f))
                l = fgets(f);
                if (l == "ASPECT=fill")     opt_fill = 1;  end
                if (l == "ASPECT=original") opt_fill = 0;  end
                if (l == "MUSIC=off")       opt_music = 0; end
                if (l == "MUSIC=on")        opt_music = 1; end
                if (l == "BOT=off")         opt_bot = 0;   end
                if (l == "BOT=easy")        opt_bot = 1;   end
                if (l == "BOT=normal")      opt_bot = 2;   end
                if (l == "BOT=hard")        opt_bot = 3;   end
            end
            fclose(f);
        end
    end
end

function save_cfg()
private
    int f;
begin
    f = fopen("options.cfg", O_WRITE);
    if (f)
        if (opt_fill == 1) fputs(f, "ASPECT=fill"); else fputs(f, "ASPECT=original"); end
        if (opt_music == 1) fputs(f, "MUSIC=on"); else fputs(f, "MUSIC=off"); end
        if (opt_bot == 0) fputs(f, "BOT=off"); end
        if (opt_bot == 1) fputs(f, "BOT=easy"); end
        if (opt_bot == 2) fputs(f, "BOT=normal"); end
        if (opt_bot == 3) fputs(f, "BOT=hard"); end
        fclose(f);
    end
end

function finish(string act)
private
    int f;
begin
    f = fopen("launcher_action.txt", O_WRITE);
    if (f)
        fputs(f, act);
        fclose(f);
    end
    exit("", 0);
end

// ---------------------------------------------------------------- drawing helpers

function clear_all()
begin
    delete_text(ALL);
    delete_draw(ALL);
    signal(type icon, s_kill);
end

// Text. al: 0 = left, 1 = centred, 2 = right (all top-aligned at y).
function label(int lx, int ly, int al, string s, int fnt)
begin
    write(fnt, lx * 3 / 4, ly * 3 / 4, al, s);
end

// Solid panel with a thin edge.
function panel(int x1, int y1, int x2, int y2)
begin
    drawing_map(0, 0);
    drawing_alpha(255);
    drawing_color(c_edge);
    draw_box(x1 * 3 / 4 - 1, y1 * 3 / 4 - 1, x2 * 3 / 4 + 1, y2 * 3 / 4 + 1);
    drawing_color(c_panel);
    draw_box(x1 * 3 / 4, y1 * 3 / 4, x2 * 3 / 4, y2 * 3 / 4);
end

// Yellow selection frame, two pixels thick.
function select_frame(int x1, int y1, int x2, int y2)
begin
    drawing_map(0, 0);
    drawing_alpha(255);
    drawing_color(c_yellow);
    draw_rect(x1 * 3 / 4, y1 * 3 / 4, x2 * 3 / 4, y2 * 3 / 4);
    draw_rect(x1 * 3 / 4 + 1, y1 * 3 / 4 + 1, x2 * 3 / 4 - 1, y2 * 3 / 4 - 1);
end

// A sprite from the game's graphics library; sz is a percentage.
process icon(int g, int ix, int iy, int sz)
begin
    file = fpg;
    graph = g;
    x = ix * 3 / 4;
    y = iy * 3 / 4;
    z = -10;
    size = sz * 3 / 4;
    loop frame; end
end

function heading(string s)
begin
    panel(20, 14, 620, 68);
    label(320, 13, 1, s, f_head);
end

function footer(string s)
begin
    panel(20, 450, 620, 474);
    label(320, 449, 1, s, f_g);
end

function body_panel()
begin
    panel(20, 82, 620, 440);
end

// 33781 -> "33,781"
function string commas(int n)
private
    string t;
    string r;
    int i;
    int l;
begin
    t = itoa(n);
    l = len(t);
    r = "";
    for (i = 0; i < l; i++)
        if (i > 0 and (l - i) % 3 == 0) r = r + ","; end
        r = r + substr(t, i, 1);
    end
    return r;
end

// ---------------------------------------------------------------- screens

function draw_screen()
begin
    clear_all();
    // 96 is the title picture with the logo, 2 is the same metal without it. Both are
    // drawn at 1.5x size to fill the 480x360 screen.
    if (cur_screen == SCR_MAIN) xput(fpg, 96, 240, 180, 0, 150, 0, 0); else xput(fpg, 2, 240, 180, 0, 150, 0, 0); end
    if (cur_screen == SCR_MAIN)    draw_main();    end
    if (cur_screen == SCR_OPTIONS) draw_options(); end
    if (cur_screen == SCR_HELP)    draw_help();    end
end

function draw_main()
private
    int i;
    int cy;
    string v;
begin
    for (i = 0; i < 4; i++)
        cy = 172 + i * 58;
        panel(130, cy - 24, 510, cy + 24);
        if (i == sel)
            select_frame(128, cy - 26, 512, cy + 26);
            label(320, cy - 22, 1, menu_item[i], f_menu_y);
        else
            label(320, cy - 22, 1, menu_item[i], f_menu_w);
        end
    end
    panel(100, 404, 540, 474);
    label(320, 402, 1, "Yours: " + commas(player_best) + "   Imerion: " + commas(creator_best), f_r);
    label(320, 428, 1, "Altitude by Daniel Imerion Eriksson", f_g);
    label(320, 449, 1, "Up/Down: choose     A: confirm", f_g);
end

function draw_options()
private
    int i;
    int cy;
    string v;
begin
    heading("Options");
    body_panel();
    for (i = 0; i < 5; i++)
        cy = 112 + i * 44;
        if (i == sel) select_frame(36, cy - 21, 604, cy + 21); end
    end
    if (opt_fill == 1) v = "Fill screen"; else v = "Original shape"; end
    label(54, 112 - 17, 0, "Screen", f_w);
    label(586, 112 - 17, 2, "<  " + v + "  >", f_y);
    if (opt_music == 1) v = "On"; else v = "Off"; end
    label(54, 156 - 17, 0, "Menu music", f_w);
    label(586, 156 - 17, 2, "<  " + v + "  >", f_y);
    if (opt_bot == 0) v = "Off"; end
    if (opt_bot == 1) v = "Easy"; end
    if (opt_bot == 2) v = "Normal"; end
    if (opt_bot == 3) v = "Hard"; end
    label(54, 200 - 17, 0, "Computer opponent", f_w);
    label(586, 200 - 17, 2, "<  " + v + "  >", f_y);
    label(54, 244 - 17, 0, "Reset high scores", f_w);
    if (reset_stage == 0) v = "Press A"; end
    if (reset_stage == 1) v = "Press A to confirm"; end
    if (reset_stage == 2) v = "Done"; end
    label(586, 244 - 17, 2, v, f_y);
    label(54, 288 - 17, 0, "Back", f_w);

    // help for the selected row
    if (sel == 0)
        label(40, 330, 0, "Original shape keeps the game's 4:3 picture", f_g);
        label(40, 355, 0, "with black bars at the sides. Fill stretches it", f_g);
        label(40, 380, 0, "across the whole screen. Applies when the", f_g);
        label(40, 405, 0, "game starts.", f_g);
    end
    if (sel == 1)
        label(40, 330, 0, "Plays the menu music while you are in this", f_g);
        label(40, 355, 0, "launcher. The game has its own sound menu.", f_g);
    end
    if (sel == 2)
        label(40, 330, 0, "A computer pilot flies Player 2 in 2P Battle", f_g);
        label(40, 355, 0, "and 2P Arcade, so you can race it. Easy makes", f_g);
        label(40, 380, 0, "mistakes, Hard rarely does. Off leaves Player 2", f_g);
        label(40, 405, 0, "idle. Applies when the game starts.", f_g);
    end
    if (sel == 3)
        label(40, 330, 0, "Sets your best score to 0 and puts the game's", f_g);
        label(40, 355, 0, "own high score back to Imerion's, so there is a", f_g);
        label(40, 380, 0, "score to beat again. This cannot be undone.", f_g);
    end
    footer("Up/Down: choose     Left/Right: change     B: back");
end

function draw_help()
begin
    if (help_page == 0) help_mission();  end
    if (help_page == 1) help_controls(); end
    if (help_page == 2) help_powerups(); end
    if (help_page == 3) help_modes();    end
    if (help_page == 4) help_tips();     end
    footer("Left/Right: page " + itoa(help_page + 1) + " of " + itoa(HELP_PAGES) + "     B: back");
end

function help_mission()
begin
    heading("The Mission");
    body_panel();
    label(40, 92,  0, "You are a space miner. Your job is to fly", f_w);
    label(40, 121, 0, "through the mine tunnels and collect the", f_w);
    label(40, 150, 0, "precious crystals hidden inside them.", f_w);

    label(40, 196, 0, "The tunnels are full of hazards. Touch the", f_w);
    label(40, 225, 0, "ground or any hazard and you crash.", f_w);

    label(40, 271, 0, "Gravity is always pulling you down, so keep", f_w);
    label(40, 300, 0, "your engine firing to stay in the air.", f_w);
    label(40, 346, 0, "Seven levels wait for you, each harder", f_w);
    label(40, 375, 0, "than the last.", f_w);
    icon(1, 548, 400, 160);
end

function help_controls()
begin
    heading("Controls");
    body_panel();
    label(40, 94,  0, "A  or  D-pad Up", f_y);
    label(64, 120, 0, "Engine: fly up. Let go and you fall.", f_w);

    label(40, 152, 0, "B  or  D-pad Right", f_y);
    label(64, 178, 0, "Thruster: push forward (yellow crystal).", f_w);

    label(40, 210, 0, "Y  or  D-pad Down", f_y);
    label(64, 236, 0, "Push down (green or blue crystal).", f_w);

    label(40, 268, 0, "Start (while flying)", f_y);
    label(64, 294, 0, "Pause. Press Start again to carry on.", f_w);

    label(40, 326, 0, "D-pad Left/Right, then A or Start", f_y);
    label(64, 352, 0, "Choose and confirm in menus.", f_w);

    label(40, 384, 0, "Select + Start", f_y);
    label(64, 410, 0, "Quit the game and return to this menu.", f_w);
end

function help_powerups()
begin
    heading("Power-ups");
    body_panel();
    icon(38, 62, 118, 260);
    label(108, 90,  0, "Red: Fire Shield", f_y);
    label(108, 118, 0, "Fly through fire unharmed.", f_w);

    icon(37, 62, 186, 260);
    label(108, 156, 0, "Green: Anti Gravity", f_y);
    label(108, 184, 0, "Gravity off. Up and Down both work.", f_w);

    icon(36, 62, 254, 260);
    label(108, 222, 0, "Blue: Reverse Gravity", f_y);
    label(108, 250, 0, "Gravity pulls you up. Use Down to fly.", f_w);

    icon(39, 62, 322, 260);
    label(108, 288, 0, "Yellow: Thruster", f_y);
    label(108, 316, 0, "Hold Right (B) to push forward.", f_w);

    icon(54, 44, 392, 200);
    label(64, 376, 0, "= 1000 points", f_w);
    icon(53, 318, 392, 200);
    label(338, 376, 0, "= 10000 points", f_w);
end

function help_modes()
begin
    heading("Game Modes");
    body_panel();
    label(40, 88,  0, "Arcade", f_y);
    label(64, 114, 0, "All seven levels in a row, with five lives.", f_w);
    label(64, 140, 0, "Crash and you restart that level.", f_w);
    label(64, 166, 0, "Lose all five and it is game over.", f_w);

    label(40, 202, 0, "Training", f_y);
    label(64, 228, 0, "Pick any level and practise it.", f_w);

    label(40, 266, 0, "2P Battle and 2P Arcade", f_y);
    label(64, 292, 0, "Two pilots fly the same level. Turn on", f_w);
    label(64, 318, 0, "Computer opponent in Options to race a", f_w);
    label(64, 344, 0, "computer pilot as Player 2.", f_w);

    label(40, 382, 0, "High score", f_y);
    label(64, 408, 0, "The menu shows yours and Imerion's.", f_w);
end

function help_tips()
begin
    heading("Tips");
    body_panel();
    label(40, 92,  0, "Tap A in short bursts to hover. Hold it", f_w);
    label(40, 118, 0, "and you shoot upward.", f_w);

    label(40, 160, 0, "Take the red crystal before a wall of", f_w);
    label(40, 186, 0, "flames, not after it.", f_w);

    label(40, 228, 0, "With reverse gravity, Down is your engine.", f_w);
    label(40, 254, 0, "Think upside down.", f_w);

    label(40, 296, 0, "Small green crystals are worth a detour:", f_w);
    label(40, 322, 0, "10000 points each.", f_w);

    label(40, 364, 0, "Practise a hard level in Training before", f_w);
    label(40, 390, 0, "risking your Arcade lives.", f_w);
end

// ---------------------------------------------------------------- test modes

// Asks the runtime to dump the next frame (SF3500_SHOT_PREFIX must be set).
function shot()
private
    int f;
    int i;
begin
    for (i = 0; i < 12; i++) frame; end
    f = fopen("shot.trigger", O_WRITE);
    fclose(f);
    for (i = 0; i < 3; i++) frame; end
end

function run_shots()
private
    int p;
begin
    player_best = 12480;
    cur_screen = SCR_MAIN; sel = 0; draw_screen(); shot();
    sel = 2; draw_screen(); shot();
    cur_screen = SCR_OPTIONS; sel = 0; draw_screen(); shot();
    sel = 1; draw_screen(); shot();
    sel = 2; opt_bot = 2; draw_screen(); shot();
    sel = 3; reset_stage = 0; draw_screen(); shot();
    reset_stage = 1; draw_screen(); shot();
    reset_stage = 2; draw_screen(); shot();
    cur_screen = SCR_HELP;
    for (p = 0; p < HELP_PAGES; p++)
        help_page = p;
        draw_screen();
        shot();
    end
end

// Settings round trip, score reset and hand-off check, no keys needed: argument "selftest".
function run_selftest()
private
    int f;
    int g_score;
    int g_player;
begin
    opt_fill = 1; opt_music = 0; opt_bot = 2;
    save_cfg();
    opt_fill = 0; opt_music = 1; opt_bot = 0;
    load_cfg();
    // pretend the player beat the creator, then reset: score.dat must hold the creator's score again
    g_score = creator_best + 9000;
    save("score.dat", g_score);
    player_best = creator_best + 9000;
    save("score-player.dat", player_best);
    reset_scores();
    load("score.dat", g_score);
    load("score-player.dat", g_player);
    f = fopen("selftest.txt", O_WRITE);
    fputs(f, "fill=" + itoa(opt_fill) + " music=" + itoa(opt_music) + " bot=" + itoa(opt_bot) + " creator=" + itoa(creator_best) + " score.dat_after_reset=" + itoa(g_score) + " player_after_reset=" + itoa(g_player));
    fclose(f);
    finish("play");
end

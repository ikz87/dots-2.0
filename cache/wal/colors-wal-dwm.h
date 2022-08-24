static const char norm_fg[] = "#fffdf8";
static const char norm_bg[] = "#101012";
static const char norm_border[] = "#27272c";

static const char sel_fg[] = "#fffdf8";
static const char sel_bg[] = "#64AFA9";
static const char sel_border[] = "#fffdf8";

static const char urg_fg[] = "#fffdf8";
static const char urg_bg[] = "#CFBFC0";
static const char urg_border[] = "#CFBFC0";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};

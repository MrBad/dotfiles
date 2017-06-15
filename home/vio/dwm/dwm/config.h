/* See LICENSE file for copyright and license details. */

#define XF86MonBrightnessUp			0x1008ff02
#define XF86MonBrightnessDown		0x1008ff03
#define XF86AudioLowerVolume		0x1008ff11
#define XF86AudioMute				0x1008ff12
#define XF86AudioRaiseVolume		0x1008ff13
#define XF86AudioPlay				0x1008ff14
#define XF86AudioStop				0x1008ff15
#define XF86AudioPrev				0x1008ff16
#define XF86AudioNext				0x1008ff17
#define XF86ScreenSaver				0x1008ff2d // fn+f2
#define Print						0xff61		

/* appearance */
static const char *fonts[] = {
	"monospace:size=9"
};
static const char dmenufont[]       = "monospace:size=9";
static const char normbordercolor[] = "#444444";
static const char normbgcolor[]     = "#222222";
static const char normfgcolor[]     = "#bbbbbb";
static const char selbordercolor[]  = "#005577";
static const char selbgcolor[]      = "#005577";
static const char selfgcolor[]      = "#eeeeee";
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int snap      = 10;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
//#define MODKEY Mod1Mask
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbgcolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]	=	{ "st", NULL };
static const char *chrmcmd[]	=	{ "/usr/bin/chromium", NULL };
static const char *lghtupcmd[]	=	{ "xbacklight", "-inc", "10", NULL };
static const char *lghtdowncmd[]=	{ "xbacklight", "-dec", "10", NULL };
static const char *volupcmd[]	=	{ "amixer", "set", "Master", "10%+", NULL };
static const char *voldowncmd[] =	{ "amixer", "set", "Master", "10%-", NULL };
static const char *volmutecmd[] =	{ "amixer", "set", "Master", "toggle", NULL };
static const char *aplaycmd[]	=	{"rhythmbox-client", "--play-pause", NULL};
static const char *astopcmd[]	=	{"rhythmbox-client", "--stop", NULL};
static const char *aprevcmd[]	=	{"rhythmbox-client", "--previous", NULL};
static const char *anextcmd[]	=	{"rhythmbox-client", "--next", NULL};
static const char *lockcmd[]	=	{"slock", NULL};
//static const char *printcmd[]	=	{"import", "-window", "root", "/home/vio/Pictures/snapshot.png", NULL};
static const char *printcmd[]	=	{"/home/develop/snap/snap", NULL};
static const char *atomcmd[]	=	{"atom", NULL};

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,   XK_p,						spawn,          {.v = dmenucmd } },
	{ MODKEY,	XK_Return,					spawn,          {.v = termcmd } },
	{ MODKEY,	XK_c,						spawn,          {.v = chrmcmd } },
	{ MODKEY,	XK_a,						spawn,          {.v = atomcmd } },
	{ 0,		XF86MonBrightnessUp,		spawn,			{.v = lghtupcmd } },
	{ 0,		XF86MonBrightnessDown,		spawn,			{.v = lghtdowncmd } },
	{ 0,		XF86AudioLowerVolume,		spawn,			{.v = voldowncmd} },
	{ 0,		XF86AudioRaiseVolume,		spawn,			{.v = volupcmd} },
	{ 0,		XF86AudioMute,				spawn,			{.v = volmutecmd } },
	{ 0,		XF86AudioPlay,				spawn,			{.v = aplaycmd} },
	{ 0,		XF86AudioStop,				spawn,			{.v = astopcmd} },
	{ 0,		XF86AudioPrev,				spawn,			{.v = aprevcmd} },
	{ 0,		XF86AudioNext,				spawn,			{.v = anextcmd} },
	{ 0,		XF86ScreenSaver,			spawn,			{.v = lockcmd} },
	{ 0,		Print,						spawn,			{.v = printcmd} },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,				XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};


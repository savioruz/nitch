import
  std/terminal,     # import standard terminal lib
  std/strutils,
  getDistroId,      # import to get distro id through /etc/os-release
  ../nitches/[getUser, getHostname,
                  getDistro, getKernel,
                  getUptime, getRam]  # import nitches to get info about user system

# the main function for drawing fetch
proc drawInfo*(asciiArt: bool) =
  let  # distro id (arch, manjaro, debian)
    distroId = getDistroId()

  #let  # logo and it color
  #  coloredLogo = getLogo(distroId)  # color + logo tuple
    # (fgRed, nitchLogo)

  const  # icons before cotegores
    userIcon   = " "  # recomended: " " or "|>"
    hnameIcon  = " "  # recomended: " " or "|>"
    distroIcon = "󰻀 "  # recomended: "󰻀 " or "|>"
    kernelIcon = "󰌢 "  # recomended: "󰌢 " or "|>"
    uptimeIcon = " "  # recomended: " " or "|>"
    shellIcon  = " "  # recomended: " " or "|>"
    pkgsIcon   = "󰏖 "  # recomended: "󰏖 " or "|>"
    ramIcon    = "󰍛 "  # recomended: "󰍛 " or "|>"
    colorsIcon = "󰏘 "  # recomended: "󰏘 " or "->"
    # please insert any char after the icon
    # to avoid the bug with cropping the edge of the icon

    dotIcon = ""  # recomended: "" or "■"
    # icon for demonstrate colors

  const  # categories
    userCat   = " user   │ "  # recomended: " user   │ "
    hnameCat  = " hname  │ "  # recomended: " hname  │ "
    distroCat = " distro │ "  # recomended: " distro │ "
    kernelCat = " kernel │ "  # recomended: " kernel │ "-
    uptimeCat = " uptime │ "  # recomended: " uptime │ "
    ramCat    = " memory │ "  # recomended: " memory │ "

  let  # all info about system
    userInfo     = getUser()          # get user through $USER env variable
    hostnameInfo = getHostname()      # get Hostname hostname through /etc/hostname
    distroInfo   = getDistro()        # get distro through /etc/os-release
    kernelInfo   = getKernel()        # get kernel through /proc/version
    uptimeInfo   = getUptime()        # get Uptime through /proc/uptime file
    ramInfo      = getRam()           # get ram through /proc/meminfo

  const  # aliases for colors
    color1 = fgRed
    color2 = fgYellow
    color3 = fgGreen
    color4 = fgCyan
    color5 = fgBlue
    color6 = fgMagenta
    color7 = fgWhite
    color8 = fgBlack
    color0 = fgDefault

  # ascii art
  if not asciiArt:
    if not isEmptyOrWhitespace(hostnameInfo):
      stdout.styledWrite(color1, "    user ", color0, ": ", color1, userInfo, color0, "@", color1, hostnameInfo, color0, "\n",)
    else:
      stdout.styledWrite(color1, "    user ", color0, ": ", color1, userInfo, color0, "\n")
    stdout.styledWrite(color3, "  distro ", color0, ": ", color3, distroInfo, color0, "\n")
    stdout.styledWrite(color4, "  kernel ", color0, ": ", color4, kernelInfo, color0, "\n")
    stdout.styledWrite(color2, "  memory ", color0, ": ", color2, ramInfo, color0, "\n")
    stdout.styledWrite(color5, "  uptime ", color0, ": ", color5, uptimeInfo, color0, "\n")
  else:
    stdout.styledWrite("\n", styleBright, "  ╭───────────╮\n")
    if not isEmptyOrWhitespace(hostnameInfo):
      stdout.styledWrite("  │ ", color2, userIcon, color0, userCat, color1, userInfo, color0, "@", color1, hostnameInfo, color0, "\n",)
    else:
      stdout.styledWrite("  │ ", color2, userIcon, color0, userCat, color1, userInfo, color0, "\n")
    stdout.styledWrite("  │ ", color3, distroIcon, color0, distroCat, color3, distroInfo, color0, "\n")
    stdout.styledWrite("  │ ", color4, kernelIcon, color0, kernelCat, color4, kernelInfo, color0, "\n")
    stdout.styledWrite("  │ ", color2, ramIcon, color0, ramCat, fgYellow, ramInfo, color0, "\n")
    stdout.styledWrite("  │ ", color5, uptimeIcon, color0, uptimeCat, color5, uptimeInfo, color0, "\n")
    stdout.styledWrite("  ╰───────────╯\n\n")

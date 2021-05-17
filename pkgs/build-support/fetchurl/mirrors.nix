rec {
  # Content-addressable Nix mirrors.
  hashedMirrors = [
    http://tarballs.nixos.org
  ];

  # Mirrors for mirror://site/filename URIs, where "site" is
  # "sourceforge", "gnu", etc.
  
  # SourceForge.
  sourceforge = [
    http://prdownloads.sourceforge.net/
    http://heanet.dl.sourceforge.net/sourceforge/
    http://surfnet.dl.sourceforge.net/sourceforge/
    http://dfn.dl.sourceforge.net/sourceforge/
    http://mesh.dl.sourceforge.net/sourceforge/
    http://ovh.dl.sourceforge.net/sourceforge/
    http://osdn.dl.sourceforge.net/sourceforge/
    http://kent.dl.sourceforge.net/sourceforge/
  ];

  sf = sourceforge;

  # GNU.
  gnu = [
    ftp://ftp.nluug.nl/pub/gnu/
    http://mirrors.kernel.org/gnu/
    http://ftp.gnu.org/pub/gnu/
  ];

  # kernel.org's /pub (/pub/{linux,software}) tree.
  kernel = [
    http://www.all.kernel.org/pub/
    http://www.eu.kernel.org/pub/
    http://www.de.kernel.org/pub/
  ];

  # Mirrors of ftp://ftp.kde.org/pub/kde/.
  kde = [
    http://ftp.scarlet.be/pub/kde/
    http://ftp.gwdg.de/pub/x11/kde/
    ftp://ftp.heanet.ie/mirrors/ftp.kde.org/
    ftp://ftp.kde.org/pub/kde/
  ];
}

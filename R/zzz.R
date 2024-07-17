# On library attachment, print message to user.
.onAttach <- function(libname, pkgname) {

  msg <- paste0(
    "\n",
    "== Welcome to RandomWalker ========================================================",
    "\nIf you find this package useful, please leave a star: ",
    "\n   https://github.com/spsanderson/RandomWalker",
    "\n",
    "\nIf you encounter a bug or want to request an enhancement please file an issue at:",
    "\n   https://github.com/spsanderson/RandomWalker/issues",
    "\n",
    "\nThank you for using RandomWalker"
  )

  packageStartupMessage(msg)

}

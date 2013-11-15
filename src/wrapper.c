/* A simple wrapper to allow the given script to be executed setuid.
 *
 * Originally written by Jan Schaumann <jschauma@twitter.com> in November
 * 2013.
 */

#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#ifndef SCRIPT
#  error: please use -DSCRIPT=\"/path/to/script\" to compile this wrapper
#endif

int
main(int argc, char **argv) {
	execve(SCRIPT, argv, 0);
	fprintf(stderr, "Unable to exec %s: %s\n", SCRIPT, strerror(errno));
	exit(1);
}

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void signal_handler(int signal) {
  puts(strsignal(signal));
  exit(EXIT_SUCCESS);
}

#define SIGNALS_COUNT 3
const int signals[] = { SIGHUP, SIGINT, SIGTERM };

int main() {
  // Set signal handlers
  for (int i = 0; i < SIGNALS_COUNT; i++) {
    if (signal(signals[i], signal_handler) != NULL) {
      exit(EXIT_FAILURE);
    }
  }
  // Infinite loop
  for (;;) pause();
}

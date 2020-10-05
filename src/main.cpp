#include <unistd.h>
#include <sys/reboot.h>
#include <iostream>

int shutdown() {
    sync();
    return reboot(RB_POWER_OFF);
}

int reboot() {
    sync();
    return reboot(RB_AUTOBOOT);
}

void printMenu() {
    std::cout << "RPi Shutdown and Restart" << std::endl;
    std::cout << "0) Exit" << std::endl;
    std::cout << "1) Shutdown" << std::endl;
    std::cout << "2) Reboot" << std::endl;
}

int main() {
    int option = 0;
    while (true) {
        printMenu();
        std::cin >> option;

        if (option == 0) {
            return 0;
        }

        if (option == 1) {
            shutdown();
        }

        if (option == 2) {
            reboot();
        }
    }
}
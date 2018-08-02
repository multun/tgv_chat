#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>
#include <netdb.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdbool.h>

#define BUFSIZE 1024

int main(int argc, char *argv[]) {

    if (argc < 2) {
        fprintf(stderr, "usage: %s <port>\n", argv[0]);
        return 1;
    }

    int portno = atoi(argv[1]);

    if (portno < 0 || portno > 65535) {
        fprintf(stderr, "invalid port: %d\n", portno);
        return 1;
    }

    int sockfd;
    if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0) {
        perror("socket");
        return 1;
    }

    if (setsockopt(sockfd, SOL_SOCKET, SO_REUSEADDR,
                   &(int){1} , sizeof(int)) < 0) {
        perror("setsockopt");
        return 1;
    }

    struct sockaddr_in serveraddr;
    memset(&serveraddr, 0, sizeof(serveraddr));
    serveraddr.sin_family = AF_INET;
    serveraddr.sin_addr.s_addr = htonl(INADDR_ANY);
    serveraddr.sin_port = htons((unsigned short)portno);

    if (bind(sockfd, (struct sockaddr *) &serveraddr,
             sizeof(serveraddr)) < 0) {
        perror("bind");
        return 1;
    }

    char buf[BUFSIZE];

    while (true) {
        ssize_t received = recvfrom(sockfd, buf, BUFSIZE, 0,
                                    NULL, NULL);
        if (received < 0) {
            perror("recvfrom");
            return 1;
        }

        if (buf[0] != '#')
            continue;

        if (write(1, buf + 1, received - 1) < 0) {
            perror("write");
            return 1;
        }
    }
}

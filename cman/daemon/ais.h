/******************************************************************************
*******************************************************************************
**
**  Copyright (C) 2005 Red Hat, Inc.  All rights reserved.
**
**  This copyrighted material is made available to anyone wishing to use,
**  modify, copy, or redistribute it subject to the terms and conditions
**  of the GNU General Public License v.2.
**
*******************************************************************************
******************************************************************************/
/* DLM Currently maxes out at 3 ! */
#define MAX_INTERFACES 8

#include <openais/totem/totem.h>

extern int ais_add_ifaddr(char *mcast, char *ifaddr, int portnum);
extern int comms_send_message(void *buf, int len,
			      unsigned char toport, unsigned char fromport,
			      int nodeid,
			      unsigned int flags);
extern void write_cman_pipe(char *message);

extern uint64_t incarnation;
extern struct totem_ip_address mcast_addr[MAX_INTERFACES];
extern struct totem_ip_address ifaddrs[MAX_INTERFACES];
extern int num_interfaces;
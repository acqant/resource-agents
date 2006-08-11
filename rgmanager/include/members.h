#ifndef _MEMBERS_H
#define _MEMBERS_H

#include <rg_types.h>

int get_my_nodeid(cman_handle_t h);
int my_id(void);
cluster_member_list_t * get_member_list(cman_handle_t h);
void free_member_list(cluster_member_list_t *ml);
int memb_online(cluster_member_list_t *ml, int nodeid);
int memb_online_name(cluster_member_list_t *ml, char *name);
int memb_name_to_id(cluster_member_list_t *ml, char *name);
char * memb_id_to_name(cluster_member_list_t *ml, int nodeid);
cman_node_t * memb_id_to_p(cluster_member_list_t *ml, int nodeid);
cman_node_t * memb_name_to_p(cluster_member_list_t *ml, char *name);
void free_member_list(cluster_member_list_t *ml);
cluster_member_list_t *memb_gained(cluster_member_list_t *old,
		 		   cluster_member_list_t *new);
cluster_member_list_t *memb_lost(cluster_member_list_t *old,
	 			 cluster_member_list_t *new);

cluster_member_list_t *member_list_dup(cluster_member_list_t *old);

#endif
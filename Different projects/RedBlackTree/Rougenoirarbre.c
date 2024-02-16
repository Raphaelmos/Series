/*

- Raphaël 
- Projet Arbre Rouge et Noir
- Small project to 
- Objectif : réaliser l'algorithme rouge et noir et pouvoir afficher en pdf celui-ci 

 Pour la compilation et l'éxecution :
  gcc -Wall -Wextra Rougenoirarbre.c -o Rougenoirarbre && ./Rougenoirarbre > g.dot && dot -Tpdf g.dot -o g.pdf && open g.pdf
 
 Under linux replace "open" with "evince" or other binary that can read a pdf

 sous linux remplacer "open" par "evince" ou autre binaire qui lit du pdf

*/


#include <stdio.h> 
#include <stdlib.h> 
#include <assert.h>
#include <time.h>

struct node { 
    int data; 
    char color; 
    struct node *left, *right, *parent; }; 
struct node* newNode(int data) { 
    struct node* temp = (struct node*)malloc(sizeof(struct node)); 
    temp->data = data; 
    temp->left = temp->right = temp->parent = NULL; 
    temp->color = 'R'; return temp; 
} 

void leftRotate(struct node **root, struct node *x) { 
    struct node *y = x->right; x->right = y->left; 
    if (y->left != NULL) y->left->parent = x; 
    if (x->parent != NULL) y->parent = x->parent; 
    if (x->parent == NULL) *root = y; y->left = x; 
    if (x != NULL) x->parent = y; 
} 
void rightRotate(struct node **root, struct node *y){ 
    struct node *x = y->left; y->left = x->right; 
    if (x->right != NULL) x->right->parent = y; 
    if (y->parent != NULL) x->parent = y->parent; 
    if (y->parent == NULL) *root = x; x->right = y; 
    if (y != NULL) y->parent = x; 
    
} 
void insertFixup(struct node **root, struct node *z) { 
    while (z != *root && z->parent->color == 'R') { 
        struct node *y; 
        if (z->parent == z->parent->parent->left) y = z->parent->parent->right; 
        else y = z->parent->parent->left; 
        if (y->color == 'R') { 
            y->color = 'B'; z->parent->color = 'B'; 
            z->parent->parent->color = 'R'; 
            z = z->parent->parent; } 
            else { if (z->parent == z->parent->parent->left && z == z->parent->left) { 
                char ch = z->parent->color ; 
                z->parent->color = z->parent->parent->color; 
                z->parent->parent->color = ch; 
                rightRotate(root, z->parent->parent); 
            } 
            if (z->parent == z->parent->parent->left && z == z->parent->right) { 
                char ch = z->color ; 
                z->color = z->parent->parent->color; 
                z->parent->parent->color = ch; 
                leftRotate(root, z->parent); 
                rightRotate(root, z->parent->parent); } 
            if (z->parent == z->parent->parent->right && z == z->parent->right) { 
                char ch = z->parent->color ; 
                z->parent->color = z->parent->parent->color; 
                z->parent->parent->color = ch; 
                leftRotate(root, z->parent->parent); } 
            if (z->parent == z->parent->parent->right && z == z->parent->left) { 
                char ch = z->color ; 
                z->color = z->parent->parent->color; 
                z->parent->parent->color = ch;                
                rightRotate(root, z->parent); 
                leftRotate(root, z->parent->parent); } } } 
    (*root)->color = 'B';
    printDot(*root);
    } 
void insert(struct node **root, int data) { 
    struct node *z = newNode(data); 
    if (*root == NULL) { 
        *root = z; 
        (*root)->color = 'B';
         return; } 
    struct node *y = NULL; 
    struct node *x = *root; 
    while (x != NULL) { 
        y = x; 
        if (z->data < x->data) x = x->left; 
        else x = x->right;
        } 
        z->parent = y; 
        if (y == NULL) *root = z; 
        else if (z->data < y->data) y->left = z; 
        else y->right = z; 
        insertFixup(root, z); 
} 

void inOrder(struct node *root) {
    if (root != NULL) {
        inOrder(root->left);
        printf("%d [color=%c];\n", root->data, root->color);
        inOrder(root->right);
    }
}

void printDot(struct node *root) {
    printf("digraph G {\n");
    inOrder(root);
    printf("}\n");
}


void preorder(struct node *root) {
  if (root == NULL)
    return;

  if(root->left) {
    printf("\t%d -> %d [color=red]\n", root->data, root->left->data);
    preorder(root->left);
  }
  if(root->right) {
    printf("\t%d -> %d [color=black]\n", root->data, root->right->data);
    preorder(root->right);
  }
}

// Programme pilote pour tester les fonctions au dessus 
int main() { 
    struct node *root = NULL; 
    // Essai avec ABR 10 / \ 0 20 \ 5  25 15 58
    insert(&root, 10); insert(&root, 0); insert(&root, 20); insert(&root, 5); insert(&root, 25); insert(&root, 15); insert(&root, 58);
// Preorder Traversal 
printf("Traversé de l'arbre Rouge Noir est \n"); printf("digraph G {\n");preorder(root);  printf("}\n"); return 0; } 

/*
int main(void) {
  node * root = NULL;
  srand(time(NULL)); // epoch 
  for(int i = 0; i < 1000; ++i) {
    int found = 0;
    data r = rand() % 1500;
    node ** pos;
    pos = insertFixup(&root, r, &found);
    if(!found)
      insert(pos, newNode(r));
  }
  printf("digraph G {\n");
  preorder(root);
  printf("}\n");
  return 0;
}

*/
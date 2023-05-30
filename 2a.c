#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

void bubbleSort(int arr[], int size) {
    for (int i = 0; i < size - 1; i++) {
        for (int j = 0; j < size - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

int main() {
    int size;
    printf("Enter the size of the array: ");
    scanf("%d", &size);

    int* arr = (int*)malloc(size * sizeof(int));
    if (arr == NULL) {
        printf("Memory allocation failed.\n");
        return 1;
    }

    printf("Enter the elements of the array:\n");
    for (int i = 0; i < size; i++) {
        printf("Element %d: ", i + 1);
        scanf("%d", &arr[i]);
    }

    pid_t pid = fork();

    if (pid < 0) {
        printf("Fork failed.\n");
        free(arr);
        return 1;
    } else if (pid == 0) {
        // Child process
        printf("Child process ID: %d\n", getpid());
        printf("Sorting will be done by the parent process.\n");
    } else {
        // Parent process
        printf("Parent process ID: %d\n", getpid());
        printf("Sorting the array...\n");
        bubbleSort(arr, size);

        // Waiting for the child process
        wait(NULL);

        printf("Sorted array: ");
        for (int i = 0; i < size; i++) {
            printf("%d ", arr[i]);
        }
        printf("\n");

        free(arr);
    }

    return 0;
}


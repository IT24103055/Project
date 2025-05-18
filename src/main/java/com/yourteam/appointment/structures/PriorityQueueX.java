
package com.yourteam.appointment.structures;

import com.yourteam.appointment.model.Appointment;

public class PriorityQueueX {
    private Appointment[] heap;
    private int size;

    public PriorityQueueX(int capacity) {
        heap = new Appointment[capacity];
        size = 0;
    }

    private int getUrgencyValue(String urgency) {
        switch (urgency.toLowerCase()) {
            case "high": return 1;
            case "medium": return 2;
            case "low": return 3;
            default: return 4;
        }
    }

    public void insert(Appointment a) {
        heap[size] = a;
        int current = size;
        while (current > 0) {
            int parent = (current - 1) / 2;
            if (getUrgencyValue(heap[current].getUrgency()) < getUrgencyValue(heap[parent].getUrgency())) {
                Appointment temp = heap[current];
                heap[current] = heap[parent];
                heap[parent] = temp;
                current = parent;
            } else {
                break;
            }
        }
        size++;
    }

    public Appointment remove() {
        if (size == 0) return null;
        Appointment result = heap[0];
        heap[0] = heap[--size];
        int current = 0;

        while (true) {
            int left = 2 * current + 1;
            int right = 2 * current + 2;
            int smallest = current;

            if (left < size && getUrgencyValue(heap[left].getUrgency()) < getUrgencyValue(heap[smallest].getUrgency())) {
                smallest = left;
            }
            if (right < size && getUrgencyValue(heap[right].getUrgency()) < getUrgencyValue(heap[smallest].getUrgency())) {
                smallest = right;
            }
            if (smallest != current) {
                Appointment temp = heap[current];
                heap[current] = heap[smallest];
                heap[smallest] = temp;
                current = smallest;
            } else {
                break;
            }
        }

        return result;
    }

    public boolean isEmpty() {
        return size == 0;
    }

    public int size() {
        return size;
    }

    public Appointment peek() {
        return size > 0 ? heap[0] : null;
    }

}

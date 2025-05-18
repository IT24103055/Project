package com.yourteam.appointment.structures;

import com.yourteam.appointment.model.Appointment;

public class SortUtil {

    public static void bubbleSort(Appointment[] arr, int length) {
        for (int i = 0; i < length - 1; i++) {
            for (int j = 0; j < length - i - 1; j++) {
                String time1 = arr[j].getTimeSlot();
                String time2 = arr[j + 1].getTimeSlot();


                if (time1 != null && time2 != null && time1.compareTo(time2) > 0) {
                    Appointment temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }
    }
}

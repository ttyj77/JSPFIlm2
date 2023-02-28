package model;

import lombok.Data;

@Data
public class TheaterDTO {

    private int id;
    private int cinema_id;
    private int scale;
    private int number; //1관 2관 - . 1,2,


}

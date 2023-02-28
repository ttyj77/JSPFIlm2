package model;

import lombok.Data;

@Data
public class CinemaDTO {

    private int id;
    private String name;
    private String location;
    private String number;
    private String information;
    private String information2;
    private String cinemaRoom;
    private String roomScale;
    private String area;
    private int city_id;

}
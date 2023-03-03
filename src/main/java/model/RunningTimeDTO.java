package model;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class RunningTimeDTO {

    private int id;
    private int film_id;
    private int theater_id;
    private Timestamp startTime;
    private Timestamp endTime;


}

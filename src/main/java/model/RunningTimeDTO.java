package model;

import lombok.Data;

import java.sql.Timestamp;
import java.util.Date;

@Data
public class RunningTimeDTO {

    private int id;
    private int film_id;
    private int theater_id;
    private Timestamp time;


}

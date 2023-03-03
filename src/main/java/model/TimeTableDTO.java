package model;

import lombok.Data;

import java.sql.Timestamp;
import java.util.Date;

@Data
public class TimeTableDTO {
    private String title;
    private int length;
    private String rating;
    private int number;
    private int scale;
    private Timestamp startTime;
    private Timestamp endTime;
    private int film_id;


}

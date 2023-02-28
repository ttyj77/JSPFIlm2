package model;

import lombok.Data;

import java.util.Date;

@Data
public class LeverUpDTO {
    private int id;
    private int user_id;
    private int oldRole;
    private int newRole;
    private Date entry_date;
    private Date modify_date;

}

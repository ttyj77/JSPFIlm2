package model;

import lombok.Data;

@Data
public class ReviewDTO {

    private int id;
    private String review;
    private int score;
    private int writer_id;
    private String nickname;
    private int film_id;


}

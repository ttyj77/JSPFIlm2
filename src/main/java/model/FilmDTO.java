package model;

import lombok.Data;

@Data
public class FilmDTO {
    private int id;
    private String title;
    private String summary;
    private String rating;

    private String english_title;
    private String country;
    private int showing;
    private String poster_image;

    private int length;
}

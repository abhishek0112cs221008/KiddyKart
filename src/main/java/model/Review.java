package model;

import java.sql.Timestamp;

public class Review {
    private String userName;
    private int rating;
    private String comment;
    private Timestamp reviewDate;

    // Getters & Setters
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public Timestamp getReviewDate() { return reviewDate; }
    public void setReviewDate(Timestamp reviewDate) { this.reviewDate = reviewDate; }
}
//=======
//package model;
//
//import java.sql.Timestamp;
//
//public class Review {
//    private String userName;
//    private int rating;
//    private String comment;
//    private Timestamp reviewDate;
//
//    // Getters & Setters
//    public String getUserName() { return userName; }
//    public void setUserName(String userName) { this.userName = userName; }
//
//    public int getRating() { return rating; }
//    public void setRating(int rating) { this.rating = rating; }
//
//    public String getComment() { return comment; }
//    public void setComment(String comment) { this.comment = comment; }
//
//    public Timestamp getReviewDate() { return reviewDate; }
//    public void setReviewDate(Timestamp reviewDate) { this.reviewDate = reviewDate; }
//}
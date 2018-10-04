package com.skilldistillery.travelapp.entities;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import org.hibernate.annotations.CreationTimestamp;

@Entity
public class Posts {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	
	private String message;
	
	@Column(name="trip_id")
	private int tripId;
	
	@Column(name="create_date")
	@CreationTimestamp
	private Date createDate;
	
	@Column(name="prof_id")
	private int profId;
	
	@OneToMany(mappedBy="post")
	private List<Comment> comments;
	
	public Posts() {

	}
	
	public Posts(int id, String message, int tripId, Date createDate, int profId, List<Comment> comments) {
		this.id = id;
		this.message = message;
		this.tripId = tripId;
		this.createDate = createDate;
		this.profId = profId;
		this.comments = comments;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public int getTripId() {
		return tripId;
	}

	public void setTripId(int tripId) {
		this.tripId = tripId;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public int getProfId() {
		return profId;
	}

	public void setProfId(int profId) {
		this.profId = profId;
	}
	
	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		return result;
	}
	
	public void addComment(Comment comment) {
		if (comments == null) comments = new ArrayList();
		
		if (!comments.contains(comment)) {
			comments.add(comment);
			if(comment.getPost() != null) {
				comment.getPost().getComments().remove(comment);
			}
			comment.setPost(this);
		}
	}
	
	public void removeComment(Comment comment) {
		comment.setPost(null);
		if (comments != null) {
			comments.remove(comment);
		}
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Posts other = (Posts) obj;
		if (id != other.id)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Posts [id=" + id + ", message=" + message + ", tripId=" + tripId + ", createDate=" + createDate
				+ ", profId=" + profId + "]";
	}
	
}

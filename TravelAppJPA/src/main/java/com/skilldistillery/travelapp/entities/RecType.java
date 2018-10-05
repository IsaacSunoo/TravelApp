package com.skilldistillery.travelapp.entities;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="rec_type")
public class RecType {

	// fields

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	private String name;

	@OneToMany(mappedBy = "recType")
	private List<Recommendation> recommendations;

	// constructors

	public RecType() {

	}

	public RecType(int id, String name, List<Recommendation> recommendations) {
		this.id = id;
		this.name = name;
		this.recommendations = recommendations;
	}

	// getters & setters

	public List<Recommendation> getRecommendations() {
		return recommendations;
	}

	public void setRecommendations(List<Recommendation> recommendations) {
		this.recommendations = recommendations;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	// helpers

	public void addRecommendation(Recommendation recommendation) {
		if (recommendations == null)
			recommendations = new ArrayList<>();

		if (!recommendations.contains(recommendation)) {
			recommendations.add(recommendation);
			if (recommendation.getRecType() != null) {
				recommendation.getRecType().getRecommendations().remove(recommendation);
			}
			recommendation.setRecType(this);
		}
	}

	public void removeRecommendation(Recommendation recommendation) {
		recommendation.setRecType(null);
		if (recommendations != null) {
			recommendations.remove(recommendation);
		}
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + id;
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result
				+ ((recommendations == null) ? 0 : recommendations.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RecType other = (RecType) obj;
		if (id != other.id)
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (recommendations == null) {
			if (other.recommendations != null)
				return false;
		} else if (!recommendations.equals(other.recommendations))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "RecType [id=" + id + ", name=" + name + "]";
	}

}

package edu.fpt.capstone.data;

public class Quizes {
	private int categoryId;
	private String categoryName;
	private byte[] categoryIcon;
	private int numOfQuestions;
	
	public Quizes() {
		super();
	}
	
	public Quizes(int categoryId, String categoryName, byte[] categoryIcon, int numOfQuestions) {
		super();
		this.categoryId = categoryId;
		this.categoryName = categoryName;
		this.categoryIcon = categoryIcon;
		this.numOfQuestions = numOfQuestions;
	}
	
	public int getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryName() {
		return categoryName;
	}
	
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	public byte[] getCategoryIcon() {
		return categoryIcon;
	}
	
	public void setCategoryIcon(byte[] categoryIcon) {
		this.categoryIcon = categoryIcon;
	}
	
	public int getNumOfQuestions() {
		return numOfQuestions;
	}
	
	public void setNumOfQuestions(int numOfQuestions) {
		this.numOfQuestions = numOfQuestions;
	}
}

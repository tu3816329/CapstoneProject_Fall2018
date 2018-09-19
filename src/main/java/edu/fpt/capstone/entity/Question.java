package edu.fpt.capstone.entity;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Chip Caber
 */
@Entity
@Table(name = "question", catalog = "math_formulas_admin", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Question.findAll", query = "SELECT q FROM Question q")
    , @NamedQuery(name = "Question.findById", query = "SELECT q FROM Question q WHERE q.id = :id")
    , @NamedQuery(name = "Question.findByIsAnswered", query = "SELECT q FROM Question q WHERE q.isAnswered = :isAnswered")})
public class Question implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id", nullable = false)
    private Integer id;
    @Basic(optional = false)
    @Lob
    @Column(name = "content", nullable = false, length = 2147483647)
    private String content;
    @Basic(optional = false)
    @Column(name = "is_answered", nullable = false)
    private boolean isAnswered;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "questionId")
    private List<UserQuestionAnswer> userQuestionAnswerList;
    @JoinColumn(name = "category_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Category categoryId;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "questionId")
    private List<QuestionChoices> questionChoicesList;

    public Question() {
    }

    public Question(Integer id) {
        this.id = id;
    }

    public Question(Integer id, String content, boolean isAnswered) {
        this.id = id;
        this.content = content;
        this.isAnswered = isAnswered;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public boolean getIsAnswered() {
        return isAnswered;
    }

    public void setIsAnswered(boolean isAnswered) {
        this.isAnswered = isAnswered;
    }

    @XmlTransient
    public List<UserQuestionAnswer> getUserQuestionAnswerList() {
        return userQuestionAnswerList;
    }

    public void setUserQuestionAnswerList(List<UserQuestionAnswer> userQuestionAnswerList) {
        this.userQuestionAnswerList = userQuestionAnswerList;
    }

    public Category getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Category categoryId) {
        this.categoryId = categoryId;
    }

    @XmlTransient
    public List<QuestionChoices> getQuestionChoicesList() {
        return questionChoicesList;
    }

    public void setQuestionChoicesList(List<QuestionChoices> questionChoicesList) {
        this.questionChoicesList = questionChoicesList;
    }

    @Override
    public String toString() {
        return "aa.Question[ id=" + id + " ]";
    }
    
}
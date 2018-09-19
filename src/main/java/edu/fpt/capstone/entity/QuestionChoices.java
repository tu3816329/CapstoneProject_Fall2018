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
@Table(name = "question_choices", catalog = "math_formulas_admin", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "QuestionChoices.findAll", query = "SELECT q FROM QuestionChoices q")
    , @NamedQuery(name = "QuestionChoices.findById", query = "SELECT q FROM QuestionChoices q WHERE q.id = :id")
    , @NamedQuery(name = "QuestionChoices.findByContent", query = "SELECT q FROM QuestionChoices q WHERE q.content = :content")
    , @NamedQuery(name = "QuestionChoices.findByIsCorrect", query = "SELECT q FROM QuestionChoices q WHERE q.isCorrect = :isCorrect")})
public class QuestionChoices implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id", nullable = false)
    private Integer id;
    @Basic(optional = false)
    @Column(name = "content", nullable = false, length = 255)
    private String content;
    @Basic(optional = false)
    @Column(name = "is_correct", nullable = false)
    private boolean isCorrect;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "choiceId")
    private List<UserQuestionAnswer> userQuestionAnswerList;
    @JoinColumn(name = "question_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Question questionId;

    public QuestionChoices() {
    }

    public QuestionChoices(Integer id) {
        this.id = id;
    }

    public QuestionChoices(Integer id, String content, boolean isCorrect) {
        this.id = id;
        this.content = content;
        this.isCorrect = isCorrect;
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

    public boolean getIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    @XmlTransient
    public List<UserQuestionAnswer> getUserQuestionAnswerList() {
        return userQuestionAnswerList;
    }

    public void setUserQuestionAnswerList(List<UserQuestionAnswer> userQuestionAnswerList) {
        this.userQuestionAnswerList = userQuestionAnswerList;
    }

    public Question getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Question questionId) {
        this.questionId = questionId;
    }

    @Override
    public String toString() {
        return "aa.QuestionChoices[ id=" + id + " ]";
    }
    
}
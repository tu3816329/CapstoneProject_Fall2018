package edu.fpt.capstone.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Chip Caber
 */
@Entity
@Table(name = "user_question_answer", catalog = "math_formulas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "UserQuestionAnswer.findAll", query = "SELECT u FROM UserQuestionAnswer u")
    , @NamedQuery(name = "UserQuestionAnswer.findById", query = "SELECT u FROM UserQuestionAnswer u WHERE u.id = :id")
    , @NamedQuery(name = "UserQuestionAnswer.findByAnswerTime", query = "SELECT u FROM UserQuestionAnswer u WHERE u.answerTime = :answerTime")})
public class UserQuestionAnswer implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id", nullable = false)
    private Integer id;
    @Basic(optional = false)
    @Column(name = "answer_time", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date answerTime;
    @JoinColumn(name = "question_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Question questionId;
    @JoinColumn(name = "choice_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private QuestionChoices choiceId;

    public UserQuestionAnswer() {
    }

    public UserQuestionAnswer(Integer id) {
        this.id = id;
    }

    public UserQuestionAnswer(Integer id, Date answerTime) {
        this.id = id;
        this.answerTime = answerTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getAnswerTime() {
        return answerTime;
    }

    public void setAnswerTime(Date answerTime) {
        this.answerTime = answerTime;
    }

    public Question getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Question questionId) {
        this.questionId = questionId;
    }

    public QuestionChoices getChoiceId() {
        return choiceId;
    }

    public void setChoiceId(QuestionChoices choiceId) {
        this.choiceId = choiceId;
    }

    @Override
    public String toString() {
        return "aa.UserQuestionAnswer[ id=" + id + " ]";
    }
    
}
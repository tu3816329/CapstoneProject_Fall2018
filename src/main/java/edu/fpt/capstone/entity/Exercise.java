package edu.fpt.capstone.entity;
import java.io.Serializable;
import javax.persistence.Basic;
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
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Chip Caber
 */
@Entity
@Table(name = "exercise", catalog = "math_formulas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Exercise.findAll", query = "SELECT e FROM Exercise e")
    , @NamedQuery(name = "Exercise.findById", query = "SELECT e FROM Exercise e WHERE e.id = :id")
    , @NamedQuery(name = "Exercise.findByAnswer", query = "SELECT e FROM Exercise e WHERE e.answer = :answer")})
public class Exercise implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(nullable = false)
    private Integer id;
    @Basic(optional = false)
    @Lob
    @Column(nullable = false, length = 2147483647)
    private String topic;
    @Column(length = 255)
    private String answer;
    @JoinColumn(name = "mathform_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Mathform mathformId;
    @JoinColumn(name = "version_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Version versionId;

    public Exercise() {
    }

    public Exercise(Integer id) {
        this.id = id;
    }

    public Exercise(Integer id, String topic) {
        this.id = id;
        this.topic = topic;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public Mathform getMathformId() {
        return mathformId;
    }

    public void setMathformId(Mathform mathformId) {
        this.mathformId = mathformId;
    }

    public Version getVersionId() {
        return versionId;
    }

    public void setVersionId(Version versionId) {
        this.versionId = versionId;
    }

    @Override
    public String toString() {
        return "entity.Exercise[ id=" + id + " ]";
    }
    
}
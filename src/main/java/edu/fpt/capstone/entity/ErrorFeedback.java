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
@Table(name = "error_feedback", catalog = "math_formulas_admin", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ErrorFeedback.findAll", query = "SELECT e FROM ErrorFeedback e")
    , @NamedQuery(name = "ErrorFeedback.findById", query = "SELECT e FROM ErrorFeedback e WHERE e.id = :id")})
public class ErrorFeedback implements Serializable {

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
    @JoinColumn(name = "formula_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private FormulaDetail formulaId;

    public ErrorFeedback() {
    }

    public ErrorFeedback(Integer id) {
        this.id = id;
    }

    public ErrorFeedback(Integer id, String content) {
        this.id = id;
        this.content = content;
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

    public FormulaDetail getFormulaId() {
        return formulaId;
    }

    public void setFormulaId(FormulaDetail formulaId) {
        this.formulaId = formulaId;
    }

    @Override
    public String toString() {
        return "aa.ErrorFeedback[ id=" + id + " ]";
    }
    
}

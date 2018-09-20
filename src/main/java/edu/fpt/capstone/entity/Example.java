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
@Table(name = "example", catalog = "math_formulas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Example.findAll", query = "SELECT e FROM Example e")
    , @NamedQuery(name = "Example.findById", query = "SELECT e FROM Example e WHERE e.id = :id")})
public class Example implements Serializable {

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

    public Example() {
    }

    public Example(Integer id) {
        this.id = id;
    }

    public Example(Integer id, String content) {
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
        return "aa.Example[ id=" + id + " ]";
    }
    
}
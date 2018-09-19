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
@Table(name = "tips_and_tricks", catalog = "math_formulas_admin", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TipsAndTricks.findAll", query = "SELECT t FROM TipsAndTricks t")
    , @NamedQuery(name = "TipsAndTricks.findByTitle", query = "SELECT t FROM TipsAndTricks t WHERE t.title = :title")
    , @NamedQuery(name = "TipsAndTricks.findById", query = "SELECT t FROM TipsAndTricks t WHERE t.id = :id")})
public class TipsAndTricks implements Serializable {

    private static final long serialVersionUID = 1L;
    @Column(name = "title", length = 50)
    private String title;
    @Basic(optional = false)
    @Lob
    @Column(name = "content", nullable = false, length = 2147483647)
    private String content;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id", nullable = false)
    private Integer id;
    @JoinColumn(name = "formula_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private FormulaDetail formulaId;

    public TipsAndTricks() {
    }

    public TipsAndTricks(Integer id) {
        this.id = id;
    }

    public TipsAndTricks(Integer id, String content) {
        this.id = id;
        this.content = content;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public FormulaDetail getFormulaId() {
        return formulaId;
    }

    public void setFormulaId(FormulaDetail formulaId) {
        this.formulaId = formulaId;
    }

    @Override
    public String toString() {
        return "aa.TipsAndTricks[ id=" + id + " ]";
    }
    
}
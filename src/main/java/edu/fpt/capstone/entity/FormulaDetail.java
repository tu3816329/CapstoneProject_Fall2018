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
@Table(name = "formula_detail", catalog = "math_formulas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "FormulaDetail.findAll", query = "SELECT f FROM FormulaDetail f")
    , @NamedQuery(name = "FormulaDetail.findById", query = "SELECT f FROM FormulaDetail f WHERE f.id = :id")})
public class FormulaDetail implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id", nullable = false)
    private Integer id;
    @Basic(optional = false)
    @Lob
    @Column(name = "detail", nullable = false, length = 2147483647)
    private String detail;
//    @OneToMany(cascade = CascadeType.ALL, mappedBy = "formulaId")
//    private List<ErrorFeedback> errorFeedbackList;
//    @OneToMany(cascade = CascadeType.ALL, mappedBy = "formulaId")
//    private List<TipsAndTricks> tipsAndTricksList;
//    @OneToMany(cascade = CascadeType.ALL, mappedBy = "formulaId")
//    private List<Example> exampleList;
    @JoinColumn(name = "category_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Category categoryId;

    public FormulaDetail() {
    }

    public FormulaDetail(Integer id) {
        this.id = id;
    }

    public FormulaDetail(Integer id, String detail) {
        this.id = id;
        this.detail = detail;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

//    @XmlTransient
//    public List<ErrorFeedback> getErrorFeedbackList() {
//        return errorFeedbackList;
//    }
//
//    public void setErrorFeedbackList(List<ErrorFeedback> errorFeedbackList) {
//        this.errorFeedbackList = errorFeedbackList;
//    }
//
//    @XmlTransient
//    public List<TipsAndTricks> getTipsAndTricksList() {
//        return tipsAndTricksList;
//    }
//
//    public void setTipsAndTricksList(List<TipsAndTricks> tipsAndTricksList) {
//        this.tipsAndTricksList = tipsAndTricksList;
//    }
//
//    @XmlTransient
//    public List<Example> getExampleList() {
//        return exampleList;
//    }
//
//    public void setExampleList(List<Example> exampleList) {
//        this.exampleList = exampleList;
//    }

    public Category getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Category categoryId) {
        this.categoryId = categoryId;
    }

    @Override
    public String toString() {
        return "aa.FormulaDetail[ id=" + id + " ]";
    }
    
}
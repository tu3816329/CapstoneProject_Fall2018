package edu.fpt.capstone.entity;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
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

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonProperty.Access;

/**
 *
 * @author Chip Caber
 */
@Entity
@Table(name = "category", catalog = "math_formulas_admin")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Category.findAll", query = "SELECT c FROM Category c")
    , @NamedQuery(name = "Category.findById", query = "SELECT c FROM Category c WHERE c.id = :id")
    , @NamedQuery(name = "Category.findByCategoryName", query = "SELECT c FROM Category c WHERE c.categoryName = :categoryName")})
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id", nullable = false)
    private Integer id;
    @Basic(optional = false)
    @Column(name = "category_name", nullable = false, length = 45)
    private String categoryName;
//    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, mappedBy = "categoryId")
//    @JsonIgnore
//    private List<Question> questionList;
    @JoinColumn(name = "grade_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Grade gradeId;
    @JoinColumn(name = "division_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Division divisionId;
//    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, mappedBy = "categoryId")
//    @JsonIgnore
//    private List<FormulaDetail> formulaDetailList;

    public Category() {
    }

    public Category(Integer id) {
        this.id = id;
    }

    public Category(Integer id, String categoryName) {
        this.id = id;
        this.categoryName = categoryName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

//    @XmlTransient
//    @JsonIgnore
//    public List<Question> getQuestionList() {
//        return questionList;
//    }
//
//    @JsonProperty
//    public void setQuestionList(List<Question> questionList) {
//        this.questionList = questionList;
//    }

    public Grade getGradeId() {
        return gradeId;
    }

    public void setGradeId(Grade gradeId) {
        this.gradeId = gradeId;
    }

    public Division getDivisionId() {
        return divisionId;
    }

    public void setDivisionId(Division divisionId) {
        this.divisionId = divisionId;
    }

//    @XmlTransient
//    @JsonIgnore
//    public List<FormulaDetail> getFormulaDetailList() {
//        return formulaDetailList;
//    }
//
//    @JsonProperty
//    public void setFormulaDetailList(List<FormulaDetail> formulaDetailList) {
//        this.formulaDetailList = formulaDetailList;
//    }

    @Override
    public String toString() {
        return "aa.Category[ id=" + id + " ]";
    }
    
}

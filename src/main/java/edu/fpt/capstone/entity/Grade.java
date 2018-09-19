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
@Table(name = "grade", catalog = "math_formulas_admin")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Grade.findAll", query = "SELECT g FROM Grade g")
    , @NamedQuery(name = "Grade.findById", query = "SELECT g FROM Grade g WHERE g.id = :id")
    , @NamedQuery(name = "Grade.findByGradeName", query = "SELECT g FROM Grade g WHERE g.gradeName = :gradeName")})
public class Grade implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id", nullable = false)
    private Integer id;
    @Basic(optional = false)
    @Column(name = "grade_name", nullable = false, length = 20)
    private String gradeName;
//    @OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL, mappedBy = "gradeId")
//    @JsonIgnore
//    private List<Category> categoryList;

    public Grade() {
    }

    public Grade(Integer id) {
        this.id = id;
    }

    public Grade(Integer id, String gradeName) {
        this.id = id;
        this.gradeName = gradeName;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getGradeName() {
        return gradeName;
    }

    public void setGradeName(String gradeName) {
        this.gradeName = gradeName;
    }

//    @XmlTransient
//    @JsonIgnore
//    public List<Category> getCategoryList() {
//        return categoryList;
//    }
//
//    @JsonProperty
//    public void setCategoryList(List<Category> categoryList) {
//        this.categoryList = categoryList;
//    }

    @Override
    public String toString() {
        return "aa.Grade[ id=" + id + " ]";
    }
    
}
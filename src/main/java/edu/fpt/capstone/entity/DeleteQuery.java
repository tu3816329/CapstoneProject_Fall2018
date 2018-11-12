package edu.fpt.capstone.entity;

import java.io.Serializable;
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
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Chip Caber
 */
@Entity
@Table(name = "delete_query", catalog = "math_formulas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "DeleteQuery.findAll", query = "SELECT d FROM DeleteQuery d")
    , @NamedQuery(name = "DeleteQuery.findById", query = "SELECT d FROM DeleteQuery d WHERE d.id = :id")
    , @NamedQuery(name = "DeleteQuery.findByQuery", query = "SELECT d FROM DeleteQuery d WHERE d.query = :query")})
public class DeleteQuery implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(nullable = false)
    private Integer id;
    @Basic(optional = false)
    @Column(nullable = false, length = 255)
    private String query;
    @JoinColumn(name = "version_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Version versionId;

    public DeleteQuery() {
    }

    public DeleteQuery(Integer id) {
        this.id = id;
    }

    public DeleteQuery(String query, Version versionId) {
        this.query = query;
        this.versionId = versionId;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getQuery() {
        return query;
    }

    public void setQuery(String query) {
        this.query = query;
    }

    public Version getVersionId() {
        return versionId;
    }

    public void setVersionId(Version versionId) {
        this.versionId = versionId;
    }

    @Override
    public String toString() {
        return "entity.DeleteQuery[ id=" + id + " ]";
    }
    
}
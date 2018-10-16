/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
@Table(catalog = "math_formulas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Exercises.findAll", query = "SELECT e FROM Exercises e")
    , @NamedQuery(name = "Exercises.findById", query = "SELECT e FROM Exercises e WHERE e.id = :id")
    , @NamedQuery(name = "Exercises.findByAnswer", query = "SELECT e FROM Exercises e WHERE e.answer = :answer")})
public class Exercises implements Serializable {

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
    @JoinColumn(name = "math_form_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Mathform mathformId;
    @JoinColumn(name = "version_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Version versionId;

    public Exercises() {
    }

    public Exercises(Integer id) {
        this.id = id;
    }

    public Exercises(Integer id, String topic) {
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
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Exercises)) {
            return false;
        }
        Exercises other = (Exercises) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entity.Exercises[ id=" + id + " ]";
    }
    
}

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
@Table(name = "error_feedback", catalog = "math_formulas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ErrorFeedback.findAll", query = "SELECT e FROM ErrorFeedback e")
    , @NamedQuery(name = "ErrorFeedback.findById", query = "SELECT e FROM ErrorFeedback e WHERE e.id = :id")})
public class ErrorFeedback implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(nullable = false)
    private Integer id;
    @Basic(optional = false)
    @Lob
    @Column(nullable = false, length = 2147483647)
    private String content;
    @JoinColumn(name = "lesson_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private Lesson lessonId;

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

    public Lesson getLessonId() {
        return lessonId;
    }

    public void setLessonId(Lesson lessonId) {
        this.lessonId = lessonId;
    }

    @Override
    public String toString() {
        return "entity.ErrorFeedback[ id=" + id + " ]";
    }
    
}

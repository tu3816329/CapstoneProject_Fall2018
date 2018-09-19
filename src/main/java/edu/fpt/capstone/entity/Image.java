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
@Table(name = "image", catalog = "math_formulas_admin", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Image.findAll", query = "SELECT i FROM Image i")
    , @NamedQuery(name = "Image.findById", query = "SELECT i FROM Image i WHERE i.id = :id")
    , @NamedQuery(name = "Image.findByPosition", query = "SELECT i FROM Image i WHERE i.position = :position")})
public class Image implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id", nullable = false)
    private Integer id;
    @Basic(optional = false)
    @Lob
    @Column(name = "image", nullable = false)
    private byte[] image;
    @Basic(optional = false)
    @Column(name = "position", nullable = false)
    private int position;
    @JoinColumn(name = "formuala_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private FormulaDetail formualaId;

    public Image() {
    }

    public Image(Integer id) {
        this.id = id;
    }

    public Image(Integer id, byte[] image, int position) {
        this.id = id;
        this.image = image;
        this.position = position;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public int getPosition() {
        return position;
    }

    public void setPosition(int position) {
        this.position = position;
    }

    public FormulaDetail getFormualaId() {
        return formualaId;
    }

    public void setFormualaId(FormulaDetail formualaId) {
        this.formualaId = formualaId;
    }

    @Override
    public String toString() {
        return "aa.Image[ id=" + id + " ]";
    }
    
}
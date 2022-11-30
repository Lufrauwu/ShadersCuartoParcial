using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ControlPoint : MonoBehaviour
{
    private float xRot, yRot = 0f;
    public Rigidbody ballRB;
    public float rotationSpeed = 5f;
    public float shootPower = 30f;
    public LineRenderer line;

    void Update()
    {
        transform.position = ballRB.position;
        if (Input.GetMouseButton(0))
        {
            xRot += Input.GetAxis("Mouse X") * rotationSpeed;
            yRot += Input.GetAxis("Mouse Y") * rotationSpeed;
            if (yRot < -10f)
            {
                yRot = -10f;
            }
            transform.rotation = Quaternion.Euler(yRot, xRot, 0f);
            line.gameObject.SetActive(true);
            line.SetPosition(0, transform.position);
            line.SetPosition(1, transform.position + transform.forward *4f);
        }

        if (Input.GetMouseButtonUp(0))
        {
            ballRB.velocity = transform.forward * shootPower;
            line.gameObject.SetActive(false);
        }
    }
}

using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChangeMaterialTrigger : MonoBehaviour
{
    [SerializeField] private Material _shader1;
    [SerializeField] private GameObject _shader1GO;
    [SerializeField] private Material _shader2;
    [SerializeField] private GameObject _shader2GO;
    [SerializeField] private Material _shader3;
    [SerializeField] private GameObject _shader3GO;
    [SerializeField] private Material _shader4;
    [SerializeField] private GameObject _shader4GO;
    [SerializeField] private Animator _shader4Animator;
    [SerializeField] private Material _shader5;
    [SerializeField] private GameObject _shader5GO;
    [SerializeField] private Material _shader6;
    [SerializeField] private GameObject _shader6GO;
    [SerializeField] private Material _shader7;
    [SerializeField] private GameObject _shader7GO;
    [SerializeField] private Material _shader8;
    [SerializeField] private GameObject _shader8GO;
    [SerializeField] private Material _shader9;
    [SerializeField] private GameObject _shader9GO;
    [SerializeField] private AudioSource _audioSource;
    [SerializeField] private GameObject _indicator;

    private void Update()
    {
        if (Input.GetMouseButtonDown(1))
        {
            _shader4Animator.SetTrigger("DOAFLIP");
        }
        if (Input.GetKeyDown(KeyCode.M))
        {
            _indicator.SetActive(_indicator);
            _audioSource.Play();
            
        }


    }

    private void OnTriggerEnter(Collider other)
    {
        Renderer rend = GetComponent<Renderer>();
        if (other.CompareTag("Shader1"))
        {
            Debug.Log("ASIES");
            rend.material = _shader1;

            
        }        
        if (other.CompareTag("Shader2"))
        {
            Debug.Log("ASIES");
            rend.material = _shader2;
        }        
        if (other.CompareTag("Shader3"))
        {
            Debug.Log("ASIES");
            rend.material = _shader3;
        }        
        if (other.CompareTag("Shader4"))
        {
            Debug.Log("ASIES");
            rend.material = _shader4;

        }        
        if (other.CompareTag("Shader5"))
        {
            Debug.Log("ASIES");
            rend.material = _shader5;
        }        
        if (other.CompareTag("Shader6"))
        {
            Debug.Log("ASIES");
            rend.material = _shader6;
        }        
        if (other.CompareTag("Shader7"))
        {
            Debug.Log("ASIES");
            rend.material = _shader7;
        }        
        if (other.CompareTag("Shader8"))
        {
            Debug.Log("ASIES");
            rend.material = _shader8;
        }        
        if (other.CompareTag("Shader9"))
        {
            Debug.Log("ASIES");
            rend.material = _shader9;
        }
    }
}

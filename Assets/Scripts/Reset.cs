using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Reset : MonoBehaviour
{
    [SerializeField] private GameObject _player;
    private void OnTriggerEnter(Collider other)
    {
        _player.transform.position = new Vector3(0, 1, 0);
    }
}

// Copyright (c) 2019 SAP SE or an SAP affiliate company. All rights reserved.
//
// This file is part of ewm-cloud-robotics
// (see https://github.com/SAP/ewm-cloud-robotics).
//
// This file is licensed under the Apache Software License, v. 2 except as noted
// otherwise in the LICENSE file (https://github.com/SAP/ewm-cloud-robotics/blob/master/LICENSE)
//

// Code generated by client-gen. DO NOT EDIT.

package v1alpha1

import (
	"time"

	v1alpha1 "github.com/SAP/ewm-cloud-robotics/go/pkg/apis/ewm/v1alpha1"
	scheme "github.com/SAP/ewm-cloud-robotics/go/pkg/client/clientset/versioned/scheme"
	v1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	types "k8s.io/apimachinery/pkg/types"
	watch "k8s.io/apimachinery/pkg/watch"
	rest "k8s.io/client-go/rest"
)

// WarehouseOrdersGetter has a method to return a WarehouseOrderInterface.
// A group's client should implement this interface.
type WarehouseOrdersGetter interface {
	WarehouseOrders(namespace string) WarehouseOrderInterface
}

// WarehouseOrderInterface has methods to work with WarehouseOrder resources.
type WarehouseOrderInterface interface {
	Create(*v1alpha1.WarehouseOrder) (*v1alpha1.WarehouseOrder, error)
	Update(*v1alpha1.WarehouseOrder) (*v1alpha1.WarehouseOrder, error)
	UpdateStatus(*v1alpha1.WarehouseOrder) (*v1alpha1.WarehouseOrder, error)
	Delete(name string, options *v1.DeleteOptions) error
	DeleteCollection(options *v1.DeleteOptions, listOptions v1.ListOptions) error
	Get(name string, options v1.GetOptions) (*v1alpha1.WarehouseOrder, error)
	List(opts v1.ListOptions) (*v1alpha1.WarehouseOrderList, error)
	Watch(opts v1.ListOptions) (watch.Interface, error)
	Patch(name string, pt types.PatchType, data []byte, subresources ...string) (result *v1alpha1.WarehouseOrder, err error)
	WarehouseOrderExpansion
}

// warehouseOrders implements WarehouseOrderInterface
type warehouseOrders struct {
	client rest.Interface
	ns     string
}

// newWarehouseOrders returns a WarehouseOrders
func newWarehouseOrders(c *EwmV1alpha1Client, namespace string) *warehouseOrders {
	return &warehouseOrders{
		client: c.RESTClient(),
		ns:     namespace,
	}
}

// Get takes name of the warehouseOrder, and returns the corresponding warehouseOrder object, and an error if there is any.
func (c *warehouseOrders) Get(name string, options v1.GetOptions) (result *v1alpha1.WarehouseOrder, err error) {
	result = &v1alpha1.WarehouseOrder{}
	err = c.client.Get().
		Namespace(c.ns).
		Resource("warehouseorders").
		Name(name).
		VersionedParams(&options, scheme.ParameterCodec).
		Do().
		Into(result)
	return
}

// List takes label and field selectors, and returns the list of WarehouseOrders that match those selectors.
func (c *warehouseOrders) List(opts v1.ListOptions) (result *v1alpha1.WarehouseOrderList, err error) {
	var timeout time.Duration
	if opts.TimeoutSeconds != nil {
		timeout = time.Duration(*opts.TimeoutSeconds) * time.Second
	}
	result = &v1alpha1.WarehouseOrderList{}
	err = c.client.Get().
		Namespace(c.ns).
		Resource("warehouseorders").
		VersionedParams(&opts, scheme.ParameterCodec).
		Timeout(timeout).
		Do().
		Into(result)
	return
}

// Watch returns a watch.Interface that watches the requested warehouseOrders.
func (c *warehouseOrders) Watch(opts v1.ListOptions) (watch.Interface, error) {
	var timeout time.Duration
	if opts.TimeoutSeconds != nil {
		timeout = time.Duration(*opts.TimeoutSeconds) * time.Second
	}
	opts.Watch = true
	return c.client.Get().
		Namespace(c.ns).
		Resource("warehouseorders").
		VersionedParams(&opts, scheme.ParameterCodec).
		Timeout(timeout).
		Watch()
}

// Create takes the representation of a warehouseOrder and creates it.  Returns the server's representation of the warehouseOrder, and an error, if there is any.
func (c *warehouseOrders) Create(warehouseOrder *v1alpha1.WarehouseOrder) (result *v1alpha1.WarehouseOrder, err error) {
	result = &v1alpha1.WarehouseOrder{}
	err = c.client.Post().
		Namespace(c.ns).
		Resource("warehouseorders").
		Body(warehouseOrder).
		Do().
		Into(result)
	return
}

// Update takes the representation of a warehouseOrder and updates it. Returns the server's representation of the warehouseOrder, and an error, if there is any.
func (c *warehouseOrders) Update(warehouseOrder *v1alpha1.WarehouseOrder) (result *v1alpha1.WarehouseOrder, err error) {
	result = &v1alpha1.WarehouseOrder{}
	err = c.client.Put().
		Namespace(c.ns).
		Resource("warehouseorders").
		Name(warehouseOrder.Name).
		Body(warehouseOrder).
		Do().
		Into(result)
	return
}

// UpdateStatus was generated because the type contains a Status member.
// Add a +genclient:noStatus comment above the type to avoid generating UpdateStatus().

func (c *warehouseOrders) UpdateStatus(warehouseOrder *v1alpha1.WarehouseOrder) (result *v1alpha1.WarehouseOrder, err error) {
	result = &v1alpha1.WarehouseOrder{}
	err = c.client.Put().
		Namespace(c.ns).
		Resource("warehouseorders").
		Name(warehouseOrder.Name).
		SubResource("status").
		Body(warehouseOrder).
		Do().
		Into(result)
	return
}

// Delete takes name of the warehouseOrder and deletes it. Returns an error if one occurs.
func (c *warehouseOrders) Delete(name string, options *v1.DeleteOptions) error {
	return c.client.Delete().
		Namespace(c.ns).
		Resource("warehouseorders").
		Name(name).
		Body(options).
		Do().
		Error()
}

// DeleteCollection deletes a collection of objects.
func (c *warehouseOrders) DeleteCollection(options *v1.DeleteOptions, listOptions v1.ListOptions) error {
	var timeout time.Duration
	if listOptions.TimeoutSeconds != nil {
		timeout = time.Duration(*listOptions.TimeoutSeconds) * time.Second
	}
	return c.client.Delete().
		Namespace(c.ns).
		Resource("warehouseorders").
		VersionedParams(&listOptions, scheme.ParameterCodec).
		Timeout(timeout).
		Body(options).
		Do().
		Error()
}

// Patch applies the patch and returns the patched warehouseOrder.
func (c *warehouseOrders) Patch(name string, pt types.PatchType, data []byte, subresources ...string) (result *v1alpha1.WarehouseOrder, err error) {
	result = &v1alpha1.WarehouseOrder{}
	err = c.client.Patch(pt).
		Namespace(c.ns).
		Resource("warehouseorders").
		SubResource(subresources...).
		Name(name).
		Body(data).
		Do().
		Into(result)
	return
}

from sklearn import datasets  
import numpy as np
import matplotlib.pyplot as plt

'''
Data creation step:Create feature set and corresponding labels.
'''
np.random.seed(0)  
feature_set, labels = datasets.make_moons(100, noise=0.10)  
plt.figure(figsize=(10,7))  
plt.scatter(feature_set[:,0], feature_set[:,1], c=labels, cmap=plt.cm.winter)
labels = labels.reshape(100, 1)



'''
Definition of sigmoid function, it's derivative function, learning rate and 
initial weights defined, where:
wh2: weights from the input_layer to hidden_layer_1
wh1: weights from the hidden_layer_1 to hidden_layer_2
wo: weights from the hidden_layer_2 to output_layer
lr: Learning rate
'''
def sigmoid(x):  
    return 1/(1+np.exp(-x))
def sigmoid_der(x):  
    return sigmoid(x) *(1-sigmoid (x))
wh2 = np.random.rand(len(feature_set[0]),4)  
wh1 = np.random.rand(4,4)  
wo = np.random.rand(4, 1)  
lr = 0.5




#Training Process Started with number of epochs=200000
for epoch in range(2000):
	'''
	Feed-Forward layer, where:
	ah2: output of hidden_layer_1
	ah1: output of hidden_layer_2
	ao:  output of output layer
	error_out: error / cost function which we want to optimize
	'''
	zh2 = np.dot(feature_set, wh2)
	ah2 = sigmoid(zh2)

	zh1 = np.dot(ah2,wh1)
	ah1 = sigmoid(zh1)

	zo = np.dot(ah1, wo)
	ao = sigmoid(zo)


	error_out = ((1 / 2) * (np.power((ao - labels), 2)))
	#print(error_out.sum())
    print(error_out)



	'''
	Back-Propogation:
		- Once the forward layer is finished, we will start wil back-propogation. 
		- In back-propogation, we tries to update the weights in all the layers in such a way that,
		  the error term gets reduced with these new weights.
		- In our network, there are three levels of weight connections, as:
				1) wo: Weights from hidden_layer_2 to output_layer
				2) wh1: Weights from hidden_layer_1 to hidden_layer_2
				3) wh2: Weights from input_layer to hidden_layer_1
		- Starting from wo to wh2, we will compute the new weight gradients.
		- For this, we will compute the derivative of cost_function w.r.t. these weights.
		- Once the weight gradients are computed we will update the weights using these gradients and learning rate.


    Phase 1: Derivtaives and chain rule equations:    
		dcost_dwo = dcost_dao * dao_dzo * dzo_dwo
		dcost_dao = derivative of cost_function w.r.t. ao(predicted)
					MSE/cost_function=1n∑ni=1(predicted−observed)2
					dcost_dao = 2(predicted−observed)
							  = 2(ao-labels)    
							  = ao-labels	#Ignoring 2 as it is constant
		dao_dzo = sigmoid_der(zo) 
		   ao = sigmoid(zo)
		   dao/dzo = d/dzo(sigmoid(zo))	
				   = sigmoid_der(zo)
		dzo_dwo = d/dwo(zo)																						*
				= d/dwo(ah11*w25+ah12*w26+ah13*w27+ah14*w28)
                = ah1
				   
	'''
	dcost_dao = ao - labels
	dao_dzo = sigmoid_der(zo) 
	dzo_dwo = ah1
	dcost_dwo = np.dot(dzo_dwo.T, dcost_dao * dao_dzo)



	'''
	Phase 2: Derivtaives and chain rule equations:   
		dcost_dwh1 = dcost_dah1 * dah1_dzh1 * dzh1_dwh1
		dcost_dah1 = dcost_dzo * dzo_dah1
		dcost_dzo = dcost_dao * dao_dzo
		dzo_dah1  = wo
		dah1_dzh1 = sigmoid_der(zh1)     
		dzh1_dwh1 = ah2
	'''
	dcost_dzo = dcost_dao * dao_dzo
	dzo_dah1 = wo
	dcost_dah1 = np.dot(dcost_dzo , dzo_dah1.T)
	dah1_dzh1 = sigmoid_der(zh1) 
	dzh1_dwh1 = ah2
	dcost_dwh1 = np.dot(dzh1_dwh1.T, dah1_dzh1 * dcost_dah1)


	'''
	Phase 3: Derivtaives and chain rule equations:   
		#dcost_dwh2 = dcost_dah2 * dah2_dzh2 * dzh2_dwh2    
		#dcost_dah2 = dcost_dzh1 * dzh1_dah2
		#dcost_dzh1 = dcost_dah1 *dah1_dzh1
				   #= (dcost_dzo * dzo_dah1) * (sigmoid_der(zh1))
		#dzh1_dah2 = wh1
		#dah2_dzh2 = sigmoid_der(zh2)     
		#dzh2_dwh2 = feature_set
	'''
	dcost_dzh1 = dcost_dah1 *dah1_dzh1
	dzh1_dah2 = wh1
	dcost_dah2 = np.dot(dcost_dzh1 , dzh1_dah2.T)
	dah2_dzh2 = sigmoid_der(zh2)    
	dzh2_dwh2 = feature_set
	dcost_dwh2 = np.dot(dzh2_dwh2.T, dah2_dzh2*dcost_dah2)

	'''
	Update Weights
	'''
	wh2 -= lr * dcost_dwh2
	wh1 -= lr * dcost_dwh1
	wo  -= lr * dcost_dwo

print(feature_set)

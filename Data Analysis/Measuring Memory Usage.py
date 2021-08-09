from memory_profiler import profile
import pickle
import numpy as np

SVC_model = pickle.load(open('SVC_model.pkl', 'rb'))
KNN_model = pickle.load(open('KNN_model.pkl', 'rb'))
NN_model = pickle.load(open('NN_model.pkl', 'rb'))
LR_model = pickle.load(open('LR_model.pkl', 'rb'))
GB_model = pickle.load(open('GB_model.pkl', 'rb'))


@profile(precision=4)
def func():
    instance_58 = [54, 1, 3, 125, 273, 0, 2, 152, 0, 0.5, 3, 1, 3]  # Expected target = 0

    instance_58 = np.array(instance_58).reshape(1, -1)

    svc_58 = SVC_model.predict(instance_58)
    knn_58 = KNN_model.predict(instance_58)
    nn_58 = NN_model.predict(instance_58)
    lr_58 = LR_model.predict(instance_58)
    gb_58 = GB_model.predict(instance_58)

    return svc_58, knn_58, nn_58, lr_58, gb_58


if __name__ == '__main__':
    func()

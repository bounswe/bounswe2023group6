import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom';
import 'tailwindcss/tailwind.css'
import axios from 'axios';


const Signup = () => {
	const navigate = useNavigate();
    const [formData, setFormData] = useState({
		username: '',
		password: '',
		email: '',
		name: '',
		surname: '',
		image: null
	  });
	  const [isSuccessful, setIsSuccessful] = useState(false);
	  const [errorMessage, setErrorMessage] = useState(null);

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setFormData({
            ...formData,
            [name]: value
        });
    }

    const handleImageChange = async (e) => {
		const file = e.target.files[0];
		const reader = new FileReader();
		reader.onloadend = () => {
			const arrayBuffer = reader.result;
			const byteArray = new Uint8Array(arrayBuffer);
			setFormData({
				...formData,
				image: byteArray
			});
		};
		reader.readAsArrayBuffer(file);
	};
	
	const handleSubmit = async (e) => {
		e.preventDefault();
		
		const { username, password, email, name, surname, image } = formData;
	  
		const data = {
			username,
			password,
			email,
			name,
			surname,
			image: Array.from(image) 
		};
	  
		try {
			const response = await axios.post('http://167.99.242.175:8080/register', data, {
				headers: {
					'Content-Type': 'application/json',
                    'Access-Control-Allow-Origin': '*'
				}
			});
		
			if (response.status === 201) {
				setIsSuccessful(true);
				setTimeout(() => {
					navigate('/login');
				}, 2000);
			}
		} catch (error) {
			if (error.response && error.response.status === 409) {
				setErrorMessage('The username already exists!');
			} else {
				setErrorMessage('An error occurred. Please try again.');
			}
		}
	};
	

    return (
        <div className='bg-gray-200 py-20'>
            <div className='max-w-md mx-auto bg-white rounded-lg overflow-hidden md:max-w-md'>
                <div className='md:flex'>
                    <div className='w-full p-3 px-6 py-10'>
                        <div className='w-full'>
                            <h1 className='text-xl text-gray-700 font-semibold mb-2'>Create an account</h1>
                            <form onSubmit={handleSubmit} className='space-y-5'>
                                <div>
                                    <label className='block mb-1 font-semibold text-gray-500'>Username</label>
                                    <input
                                        name='username'
                                        className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
                                        type='text'
                                        onChange={handleInputChange}
                                    />
                                </div>
                                <div>
                                    <label className='block mb-1 font-semibold text-gray-500'>Full Name</label>
                                    <input
                                        name='name'
                                        className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
                                        type='text'
                                        onChange={handleInputChange}
                                    />
                                </div>
                                <div>
                                    <label className='block mb-1 font-semibold text-gray-500'>Surname</label>
                                    <input
                                        name='surname'
                                        className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
                                        type='text'
                                        onChange={handleInputChange}
                                    />
                                </div>
                                <div>
                                    <label className='block mb-1 font-semibold text-gray-500'>Email</label>
                                    <input
                                        name='email'
                                        className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
                                        type='email'
                                        onChange={handleInputChange}
                                    />
                                </div>
                                <div>
                                    <label className='block mb-1 font-semibold text-gray-500'>Password</label>
                                    <input
                                        name='password'
                                        className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
                                        type='password'
                                        onChange={handleInputChange}
                                    />
                                </div>
                                <div>
                                    <label className='block mb-1 font-semibold text-gray-500'>Profile Image</label>
                                    <input
                                        name='image'
                                        className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
                                        type='file'
                                        accept="image/*"
                                        onChange={handleImageChange}
                                    />
                                </div>
                                <button className='w-full h-10 px-3 text-white transition-colors duration-150 bg-blue-600 rounded-lg focus:shadow-outline hover:bg-blue-700'>
                                    Sign up
                                </button>
                            </form>
							{isSuccessful && <p className="text-green-500">Successfully registered. Redirecting...</p>}
            				{errorMessage && <p className="text-red-500">{errorMessage}</p>}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    )
}

export default Signup

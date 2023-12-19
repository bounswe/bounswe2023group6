import React, { useState, useEffect } from 'react'
import {
    Dialog,
    DialogTitle,
    DialogContent,
    TextField,
    DialogActions,
    Button,
    IconButton,
} from '@mui/material'
import CloseIcon from '@mui/icons-material/Close'
import axios from 'axios'
import EditIcon from '@mui/icons-material/Edit'

export default function EditProfile(props) {
    const [open, setOpen] = useState(false)
    const [formData, setFormData] = useState({
        title: props.user.title,
        company: props.user.company,
        about: props.user.about,
        image:  null
    });

    const axiosInstance = axios.create({
        baseURL: `${process.env.REACT_APP_API_URL}`
    })

    useEffect(() => {
        setFormData({
            title: props.user.title || '',
            company: props.user.company || '',
            about: props.user.about || '',
            image: props.user.profilePicture || null
        });
    }, [props.user]);

    const handleClickOpen = () => {
        setOpen(true)
    }

    const handleClose = () => {
        setOpen(false)
    }

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

    const onSubmit = async (e) => {
        e.preventDefault();
        const { title, company, about, image } = formData;

        const request = { title, company, about };
        const formDataToSend = new FormData();
        formDataToSend.append('request', new Blob([JSON.stringify(request)], { type: 'application/json' }));
        if (image) {
            const file = new File([image], 'image.png', { type: 'image/png' });
            formDataToSend.append('image', file);
        }

        axiosInstance.defaults.withCredentials = true;
        axiosInstance.post('/user', formDataToSend, {
            withCredentials: true,
            headers: {
                'Content-Type': 'multipart/form-data'
            },
        })
            .then((response) => {
                console.log(response);
                if (response.status === 200) {
                    handleClose();
                }
               window.location.reload();
            })
            .catch((error) => {
                console.log(error);
            });
    };



    return (
        <div>
            <Button onClick={handleClickOpen}>
                <EditIcon sx={{ color: 'black'}} />
            </Button>
            <Dialog open={open} onClose={handleClose}>
                <DialogTitle>
                    Edit Profile
                    <IconButton edge='end' color='inherit' onClick={handleClose} sx={{ position: 'absolute', right: 8, top: 8 }}>
                        <CloseIcon />
                    </IconButton>
                </DialogTitle>
                <DialogContent>
                    <TextField
                        label='About Me'
                        required
                        fullWidth
                        margin='normal'
                        name='about'
                        value={formData.about || ''}
                        multiline
                        minRows={4}
                        onChange={(event) => handleInputChange(event)}
                    />
                    <TextField
                        label='Title'
                        required
                        fullWidth
                        margin='normal'
                        name='title'
                        value={formData.title}
                        onChange={(event) => handleInputChange(event)}
                    />
                    <TextField
                        label='Company'
                        required
                        fullWidth
                        margin='normal'
                        name='company'
                        value={formData.company}
                        onChange={(event) => handleInputChange(event)}
                    />
                    <div>
                        <label className='block mb-1 font-semibold text-gray-500'>Profile Image</label>
                        <input
                            name='image'
                            className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
                            type='file'
                            accept="image/*"
                            onChange={handleImageChange}
                        />
                        <label className='block text-xs mt-1 mb-1 font-light text-gray-500'>(Maximum 1 MB)</label>
                    </div>
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleClose}>Cancel</Button>
                    <Button type='submit' onClick={onSubmit}>
                        Edit
                    </Button>
                </DialogActions>
            </Dialog>
        </div>
    )
}

import React, { useState } from 'react'
import {
    Dialog,
    DialogTitle,
    DialogContent,
    TextField,
    DialogActions,
    Button,
    IconButton,
    MenuItem,
    OutlinedInput,
    FormControl,
    Select,
    InputLabel
} from '@mui/material'
import CloseIcon from '@mui/icons-material/Close'
import { useForm } from 'react-hook-form'
import axios from 'axios'
import EditIcon from '@mui/icons-material/Edit'

export default function EditPost(props) {
    const [open, setOpen] = useState(false)
    const { handleSubmit } = useForm()
    const [title, setTitle] = useState(props.post.title)
    const [content, setContent] = useState(props.post.content)
    const [tag, setTag] = useState(props.post.tags)
    const [category, setCategory] = useState(props.post.category)
    const postId = props.post.postId;

    const axiosInstance = axios.create({
        baseURL: `${process.env.REACT_APP_API_URL}`
    })

    const handleClickOpen = () => {
        setOpen(true)
    }

    const handleClose = () => {
        setOpen(false)
    }

    const onSubmit = () => {
        axiosInstance.defaults.withCredentials = true;
        axiosInstance.put(`/forum/posts/${postId}`, {
            title,
            content,
            category,
            tag
        }, {
            withCredentials: true
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


    const tags = ['gamer', 'rpg', 'moba', 'lol', 'fifa', 'gta', 'fortnite', 'horror']

    const categories = ['GUIDE', 'REVIEW', 'DISCUSSION']

    return (
        <div>
            <Button onClick={handleClickOpen}>
                <EditIcon sx={{ color: 'black'}} />
            </Button>
            <Dialog open={open} onClose={handleClose}>
                <DialogTitle>
                    Edit Post
                    <IconButton edge='end' color='inherit' onClick={handleClose} sx={{ position: 'absolute', right: 8, top: 8 }}>
                        <CloseIcon />
                    </IconButton>
                </DialogTitle>
                <DialogContent>
                    <TextField
                        label='Title'
                        required
                        fullWidth
                        margin='normal'
                        value={title}
                        onChange={(event) => {
                            setTitle(event.target.value)
                        }}
                    />
                    <TextField
                        label='Content'
                        required
                        fullWidth
                        margin='normal'
                        value={content}
                        multiline
                        minRows={4}
                        onChange={(event) => {
                            setContent(event.target.value)
                        }}
                    />
                    <FormControl fullWidth margin='normal'>
                        <InputLabel id='demo-multiple-name-label'>Tags</InputLabel>
                        <Select
                            multiple
                            value={tag}
                            onChange={(event) => {
                                setTag(event.target.value)
                            }}
                            input={<OutlinedInput label='Name' />}
                        >
                            {tags.map((name) => (
                                <MenuItem key={name} value={name}>
                                    {name}
                                </MenuItem>
                            ))}
                        </Select>
                    </FormControl>
                    <FormControl fullWidth margin='normal'>
                        <InputLabel htmlFor='max-width'>Category</InputLabel>
                        <Select
                            label='Category'
                            value={category}
                            onChange={(event) => {
                                setCategory(event.target.value)
                            }}
                        >
                            {categories.map((name) => (
                                <MenuItem key={name} value={name}>
                                    {name}
                                </MenuItem>
                            ))}
                        </Select>
                    </FormControl>
                </DialogContent>
                <DialogActions>
                    <Button onClick={handleClose}>Cancel</Button>
                    <Button type='submit' onClick={handleSubmit(onSubmit)}>
                        Edit
                    </Button>
                </DialogActions>
            </Dialog>
        </div>
    )
}

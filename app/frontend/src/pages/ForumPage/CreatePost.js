import React, { useState } from 'react';
import {
    Dialog,
    DialogTitle,
    DialogContent,
    TextField,
    DialogActions,
    Button,
    IconButton,
    MenuItem, OutlinedInput,
    FormControl,
    Select,
    InputLabel
} from '@mui/material';
import CloseIcon from '@mui/icons-material/Close';
import { useForm } from 'react-hook-form';
import axios from 'axios';


export default function CreatePost() {
    const api_url = process.env.REACT_APP_API_URL;
    const [open, setOpen] = useState(false);
    const {  handleSubmit } = useForm();
    const [title, setTitle] = useState(false);
    const [content, setContent] = useState(false);
    const [tag, setTag] = useState([]);
    const [category, setCategory] = useState(false);

    const axiosInstance = axios.create({
        baseURL: `http://localhost:8080`,
    });

    const handleClickOpen = () => {
        setOpen(true);
    };

    const handleClose = () => {
        setOpen(false);
        clearData();
    };

    const onSubmit = (event) => {
        const postData = {
            title: title,
            content: content,
            category: category
        }

        axiosInstance.post(`${api_url}/forum/posts`, {
            postData
        })
            .then((response) => {
                console.log(response);
            })
            .catch((error) => {
                console.log(error);
            });

    };

    const clearData = () => {
        setTitle("");
        setContent("");
        setTag([]);
        setCategory("");
    }


    const tags = [
        'gamer',
        'rpg',
        'moba',
        'lol',
        'fifa',
        'gta',
        'fortnite',
        'horror',
    ];

    const categories = [
        'Guide',
        'Review',
        'Discussion'
    ]


    return (
        <div>
            <Button variant="outlined" onClick={handleClickOpen}>
                Create Post
            </Button>
            <Dialog open={open} onClose={handleClose}>
                <DialogTitle>Create Post
                    <IconButton
                        edge="end"
                        color="inherit"
                        onClick={handleClose}
                        sx={{ position: 'absolute', right: 8, top: 8 }}
                    >
                        <CloseIcon />
                    </IconButton>
                </DialogTitle>
                <DialogContent>
                    <TextField  label="Title" required fullWidth margin="normal" onChange={(event) => {setTitle(event.target.value);}} />
                    <TextField  label="Content"  required fullWidth  margin="normal"  multiline  minRows={4} onChange={(event) => {setContent(event.target.value);}}/>
                    <FormControl fullWidth margin="normal">
                        <InputLabel id="demo-multiple-name-label">Tags</InputLabel>
                        <Select
                            multiple
                            value={tag}
                            onChange={(event) => {setTag(event.target.value);}}
                            input={<OutlinedInput label="Name" />}
                        >
                            {tags.map((name) => (
                                <MenuItem
                                    key={name}
                                    value={name}
                                >
                                    {name}
                                </MenuItem>
                            ))}
                        </Select>
                    </FormControl>
                    <FormControl fullWidth margin="normal">
                        <InputLabel htmlFor="max-width">Category</InputLabel>
                        <Select
                            label="Category"
                            value={category}
                            onChange={(event) => {setCategory(event.target.value);}}
                        >
                            {categories.map((name) => (
                                <MenuItem
                                    key={name}
                                    value={name}
                                >
                                    {name}
                                </MenuItem>
                            ))}
                        </Select>
                    </FormControl>

                </DialogContent>
                <DialogActions>
                    <Button onClick={handleClose}>Cancel</Button>
                    <Button type="submit" onClick={handleSubmit(onSubmit)}>Create</Button>
                </DialogActions>
            </Dialog>
        </div>
    );
}

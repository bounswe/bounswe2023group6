import * as React from 'react';
import Box from '@mui/material/Box';
import FormLabel from '@mui/material/FormLabel';
import FormControl from '@mui/material/FormControl';
import FormGroup from '@mui/material/FormGroup';
import FormControlLabel from '@mui/material/FormControlLabel';
import Checkbox from '@mui/material/Checkbox';
import { grey } from '@mui/material/colors';

const TagSelection = ({ tags, selectedTags, handleTagChange }) => {
  const handleCheckboxChange = (event, tag) => {
    const updatedTags = event.target.checked
      ? [...selectedTags, tag]
      : selectedTags.filter((selectedTag) => selectedTag !== tag);

    handleTagChange(updatedTags);
  };

  const tagCheckboxes = tags.map((tag) => (
    <FormControlLabel
      key={tag}
      control={
        <Checkbox
          checked={selectedTags.includes(tag)}
          onChange={(event) => handleCheckboxChange(event, tag)}
          name={tag}
          style={{ color: grey[800] }}
        />
      }
      style={{ color: grey[800] }}
      label={tag}
    />
  ));

  return (
    <Box sx={{ display: 'flex' }}>
      <FormControl sx={{ m: 2 }} component="fieldset" variant="standard">
        <FormLabel component="legend" style={{ color: grey[900] }}>Select Tags</FormLabel>
        <FormGroup>
          {tagCheckboxes}
        </FormGroup>
      </FormControl>
    </Box>
  );
};

export default TagSelection;

# VIM Fundamentals for Linux Sysadmins

## Course Overview
This bonus course focuses on mastering the essential VIM fundamentals over 7 days. Each day is structured into three segments:

## Module 1: Getting Started (Days 1-2)

### Day 1: First Contact with VIM
**Segment 1: The Basics**
1. Complete first section of `vimtutor`
2. Learn essential commands:
   - `vim filename` - Open/create file
   - `i` - Enter insert mode
   - `Esc` - Return to normal mode
   - `:w` - Save changes
   - `:q` - Quit
   - `:wq` or `ZZ` - Save and quit
   - `:q!` - Quit without saving

**Segment 2: Building Muscle Memory**
1. Create five different files
2. Practice mode switching 50 times
3. Write and save content in each file
4. Practice recovering from common mistakes:
   - Accidentally pressed keys in normal mode
   - Forgot to enter insert mode
   - Trying to quit without saving

**Segment 3: First Real Task**
1. Create a simple bash script template
2. Add standard sections:
   - Shebang line
   - Comments
   - Basic variables
   - Simple functions
3. Save and reopen multiple times

### Day 2: Comfort Zone
**Segment 1: More Basic Operations**
1. Complete second section of `vimtutor`
2. Practice quick save and exit combinations
3. Learn to read VIM messages and errors
4. Understand modes in depth:
   - Normal mode
   - Insert mode
   - Visual mode (introduction)

**Segment 2: Error Recovery**
1. Create deliberate errors and fix them:
   - Write without insert mode
   - Exit without saving needed changes
   - Get stuck in different modes
2. Practice until you can recover without thinking

**Segment 3: Real Config Practice**
1. Copy `/etc/hosts` file
2. Make various modifications:
   - Add new host entries
   - Modify existing entries
   - Add comments
   - Save different versions

## Module 2: Navigation (Days 3-4)

### Day 3: Basic Movement
**Segment 1: Core Movement Commands**
- Master the basics:
  - `h` - Left
  - `j` - Down
  - `k` - Up
  - `l` - Right
  - `w` - Next word
  - `b` - Previous word
  - `0` - Line start
  - `$` - Line end

**Segment 2: Movement Drills**
1. Create a "movement course" file
2. Practice moving between marked points
3. Time your navigation speed
4. Compete against your previous times

**Segment 3: Applied Navigation**
1. Navigate through `/etc/ssh/sshd_config`:
   - Find specific settings
   - Move between sections
   - Locate comments
   - Jump to line numbers

### Day 4: Advanced Movement
**Segment 1: Extended Movement**
- Learn efficient jumps:
  - `gg` - File start
  - `G` - File end
  - `{` - Previous paragraph
  - `}` - Next paragraph
  - `Ctrl+f` - Page down
  - `Ctrl+b` - Page up

**Segment 2: Speed Training**
1. Work with a large configuration file
2. Practice jumping between sections
3. Find specific lines quickly
4. Navigate through code blocks

**Segment 3: Real-world Navigation**
1. Work with system logs
2. Jump between error messages
3. Navigate through long configuration files
4. Practice quick file browsing

## Module 3: Essential Editing (Days 5-7)

### Day 5: Basic Editing
**Segment 1: Edit Commands**
- Master core editing:
  - `x` - Delete character
  - `dd` - Delete line
  - `yy` - Copy line
  - `p` - Paste after
  - `P` - Paste before
  - `u` - Undo
  - `Ctrl + r` - Redo

**Segment 2: Editing Drills**
1. Create practice documents
2. Delete and replace text
3. Copy and paste sections
4. Practice undo/redo chains

**Segment 3: System File Editing**
1. Work with `/etc/fstab` copy:
   - Add mount points
   - Remove entries
   - Comment lines
   - Fix formatting

### Day 6: Intermediate Editing
**Segment 1: Combined Commands**
- Learn efficient combinations:
  - `dw` - Delete word
  - `d$` - Delete to line end
  - `d0` - Delete to line start
  - `cc` - Change whole line
  - `cw` - Change word

**Segment 2: Practical Application**
1. Edit service configuration files
2. Modify system settings
3. Update network configurations
4. Clean up log files

**Segment 3: Speed Challenges**
1. Timed editing tasks
2. Configuration file cleanup
3. Quick text transformation
4. Error correction sprints

### Day 7: Editing Mastery
**Segment 1: Advanced Operations**
- Master text objects:
  - `ciw` - Change inner word
  - `ci"` - Change inside quotes
  - `di(` - Delete inside parentheses
  - `yi{` - Yank inside braces

**Segment 2: Integration Practice**
1. Combine all learned commands
2. Work with multiple files
3. Practice common scenarios
4. Time your operations

## Daily Success Metrics
By end of each day, you should be able to:
- Day 1: Open, edit, save, and exit files confidently
- Day 2: Understand and recover from common errors
- Day 3: Navigate small files without arrow keys
- Day 4: Move through large files efficiently
- Day 5: Perform basic edits without hesitation
- Day 6: Combine movement and editing commands
- Day 7: Edit configuration files with confidence

## Practice Tips
1. Use `vimtutor` during breaks
2. Disable arrow keys completely
3. Keep a command log of new discoveries
4. Time your editing operations
5. Practice with real system files (copies)

Remember: Focus on accuracy first, then build speed.

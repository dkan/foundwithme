class UsersController < ApplicationController
  def index
    if params[:query]
      @users = User.near(params[:query][:location], 100)
      @users = @users.where(sql_query)
      @users = @users.joins(:user_skills).where(:user_skills => {skill_id: skill_ids})
        .group("users.id")
        .having("count(user_id) = ?", skills_count) if params[:query][:skills]
      @users = @users.joins(:user_interests).where(:user_interests => {interest_id: interest_ids})
        .group("users.id")
        .having("count(user_id) = ?", interests_count) if params[:query][:interests]
      @users.to_a.delete(current_user)
    else
      @users = User.near([current_user.latitude, current_user.longitude], 100)
    end

    respond_to do |format|
      format.json { render json: @users, status: :ok }

      format.html
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.json { render json: 'User updated.', status: :ok }
      else
        format.json { render json: 'Unable to update user.', status: :error }
      end 
    end
  end

  def update_user_skills
    
    respond_to do |format|
      if UserSkill.update_user_skills(current_user.id, params[:skills], params[:name])
        format.json { render json: 'User updated.', status: :ok }
      else
        format.json { render json: 'Unable to update user.', status: :error }
      end 
    end
  end

  def edit
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def sql_query
    query = ['']
    if params[:query][:roles]
      roles_query = ""
      params[:query][:roles].each_with_index do |r, i|
        roles_query += ' OR ' if i > 0
        roles_query += 'role = ?'
        query << r
      end
      query[0] += " AND (#{roles_query})"
    end

    if params[:query][:statuses]
      statuses_query = ""
      params[:query][:statuses].each_with_index do |s, i|
        statuses_query += ' OR ' if i > 0
        statuses_query += 'status = ?'
        query << s
      end
      query[0] += " AND (#{statuses_query})"
    end

    if params[:query][:milestones]
      milestones_query = ""
      params[:query][:milestones].each_with_index do |m, i|
        milestones_query += ' OR ' if i > 0
        milestones_query += 'milestone = ?'
        query << m
      end
      query[0] += " AND (#{milestones_query})"
    end

    if params[:query][:lookingFor]
      looking_for_query = ""
      params[:query][:lookingFor].each_with_index do |l, i|
        looking_for_query += ' OR ' if i > 0
        looking_for_query += 'looking_for = ?'
        query << l
      end
      query[0] += " AND (#{looking_for_query})"
    end

    if query[0][0..4] == ' AND '
      query[0].slice!(0..4)
    end

    return query
  end

  def skill_ids
    ids = []
    if params[:query][:skills]
      params[:query][:skills].each_value do |v|
        ids << v['id']
      end
    end
    return ids
  end

  def skills_count
    params[:query][:skills] ? params[:query][:skills].count : 0
  end

  def interest_ids
    ids = []
    if params[:query][:interests]
      params[:query][:interests].each_value do |v|
        ids << v['id']
      end
    end
    return ids
  end

  def interests_count
    params[:query][:interests] ? params[:query][:interests].count : 0
  end
end
